import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/custom_location_card.dart';
import 'package:pathly/models/full_routes_data_model/full_routes_data_model.dart';
import 'package:pathly/models/full_routes_data_model/route.dart';
import 'package:pathly/models/location_info/lat_lng.dart';
import 'package:pathly/models/location_info/location.dart';
import 'package:pathly/models/location_info/location_info.dart';
import 'package:pathly/models/places_details/places_details_model.dart';
import 'package:pathly/models/slidingpanel_button_model.dart';
import 'package:pathly/services/fetch_routes_service_class.dart';
import 'package:pathly/services/google_maps_places_service.dart';
import 'package:pathly/utils/format_distance.dart';
import 'package:pathly/utils/format_time.dart';
import 'package:pathly/utils/get_latlng_bounds.dart';
import 'package:pathly/utils/location_service.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/views/start_trip_view.dart';
import 'package:pathly/views/animated-logo-view.dart';
import 'package:pathly/widgets/instrucion_card.dart';
import 'package:pathly/widgets/rqi_widget.dart';
import 'package:pathly/widgets/sliding_panel_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShowRouteView extends StatefulWidget {
  const ShowRouteView({required this.placesDetailsModel,required this.filterType,required this.originLocation,super.key});
  final PlacesDetailsModel placesDetailsModel;
  final String filterType;
  final  LatLng originLocation;

  @override
  State<ShowRouteView> createState() => _ShowRouteViewState();
}

class _ShowRouteViewState extends State<ShowRouteView> {
   late CameraPosition initialCameraPosition;
   late LatLng originLocation;
  late GoogleMapController googleMapController;
  double currentZoomLevel = 11;
  bool isZoomIn = false;
   late LocationService locationService;
   late BitmapDescriptor customIcon;
   late BitmapDescriptor originMarkerIcon;
  late BitmapDescriptor destinationMarkerIcon;
  Set<Marker> markers = {};
   String distinationName = '';
   Set<Polyline> polylines = {};
   List<LatLng> fullRoutePoints = [];
  bool isArrived = false;
   List<Polyline> allPolylines = [];
  Set<Polyline> activePolylines = {};
  late LatLng distinationLocation;
   late GoogleMapsPlacesService googleMapsPlacesService;
  late FetchRoutesServiceClass fetchRoutesService;
  String mapStyle='';
  FullRoutesDataModel? fetchedRoutes;
   RouteModel? selectedRoute;
late final List<VoidCallback?> buttonsAction;



  @override
  void initState() {
    originLocation=widget.originLocation;
    distinationLocation=LatLng(widget.placesDetailsModel.geometry!.location!.lat!, widget.placesDetailsModel.geometry!.location!.lng!);
    initMapStyle();
    loadCustomMarker();
    googleMapsPlacesService = GoogleMapsPlacesService();
    locationService = LocationService();
    fetchRoutesService = FetchRoutesServiceClass();
    buttonsAction = [
    () {
      Get.to(() => AnimatedLogoView(
  onAnimationComplete: () {
    Get.off(() => StartTripView(
      originLocation: originLocation,
      destinationLocation: distinationLocation,
      fullRoutePoints: fullRoutePoints,
      allPolylines: allPolylines,
      selectedRoute: selectedRoute!,
    ));
  },
));
    },
    null,
    null,
    null,
  ];
    super.initState();
  }
  @override
  void dispose() {
   googleMapController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
       Stack(
        children: [
          GoogleMap(
            style: mapStyle,
            polylines: polylines,
            zoomControlsEnabled: false,
             markers: markers,
            initialCameraPosition: CameraPosition(
              target: widget.originLocation,
              zoom: 12,
            ),
          onMapCreated: (controller)async {
            googleMapController=controller;
            

  var points = await getRouteData();
  displaypoints(points);
             
          },
          ),
                             Positioned(top: 40,
                              child: IconButton(onPressed: (){
                                Get.back();
                              },icon: Icon(Icons.arrow_back_ios,color: Colors.white,),padding: EdgeInsets.zero,)),
                               Positioned(
                                right: 0,
                                bottom: 200,
                                 child: SizedBox(
                                  width: 100,
                                   child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                         crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              RqiWidget(alignment: Alignment.centerRight,),
                                              SizedBox(height: 20,),

                                               GestureDetector(
                                                       onTap: () {
                                                         toggleZoomLevel();
                                                       },
                                                       child: Padding(
                                                         padding: const EdgeInsets.only(right: 12.0),
                                                         child: CircleAvatar(
                                                           backgroundColor: Colors.white,
                                                           child:
                                                               isZoomIn
                                                                   ? SvgPicture.asset(
                                                                                             "assets/icons/compass.svg",
                                                                                             color: kPrimaryColor,
                                                                   )
                                                                   : SvgPicture.asset("assets/icons/focus.svg"),
                                                         ),
                                                       ),
                                                     ),
                                            ],
                                          ),
                                 ),
                               ),
          Positioned(
            top: 40,
            right: 0,
            left: 0,

            child: CustomLocationCard(distinationName: widget.placesDetailsModel.name!,)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SlidingUpPanel(
                padding: EdgeInsets.zero,
                color: Colors.white,
                collapsed: Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.all(25),
                  child: Text('Drive', style: Styles.stylePrimaryColorbold18),
                ),

                

                minHeight: 55,

                backdropTapClosesPanel: false,
                maxHeight: MediaQuery.of(context).size.height * 0.7,
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                panel:
   Column(
  children: [
    Container(
      width: 70,
      height: 6,
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xff999999),
        borderRadius: BorderRadius.circular(3),
      ),
    ),
    Container(
      alignment: Alignment.topLeft,
      margin: EdgeInsets.only(left: 20),
      child: Text('Drive', style: Styles.stylePrimaryColorbold18),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Image.asset("assets/icons/drive.png", height: 28),
    ),
    Divider(color: Color(0xffE1E1E1)),
    Expanded(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
         if(selectedRoute!=null)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: formatDuration(selectedRoute?.duration),
                    style: GoogleFonts.poppins(
                        color: Color(0xff019C4C), fontSize: 18),
                  ),
      
TextSpan(
  text: " (${formatDistance(selectedRoute?.distanceMeters)})\n",
  style: Styles.stylePrimaryColorbold18,
),

   

                  TextSpan(
                      text: widget.filterType.isEmpty?"Best RQI (Quality)":widget.filterType,
                      style: Styles.styleMediamgrey14),
                ],
              ),
            ),
          )
          else

    Center(child: CircularProgressIndicator(color: kPrimaryColor,)),
          
          Container(
            alignment: Alignment.topLeft,
            margin: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              "Steps",
              style: GoogleFonts.poppins(
                  color: Color(0xff7D7E7F),
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Image.asset(
                    "assets/icons/origin_marker.png",
                    color: Color(0xff035CA0),
                    height: 28,
                  ),
                ),
                Text(
                  "Your Location",
                  style: GoogleFonts.poppins(
                      color: Color(0xff1E1E1E),
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),

        
          if (selectedRoute != null)
            ListView.builder(
              itemCount: selectedRoute!.legs!
                  .expand((leg) => leg.steps!)
                  .toList()
                  .length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final allSteps = selectedRoute!.legs!
                    .expand((leg) => leg.steps!)
                    .toList();
                final step = allSteps[index];

                final String instructionText =
                    step.navigationInstruction?.instructions ?? '';
                final int instructionDistance =
                    step.distanceMeters ?? 0;
                final String maneuver =
                    step.navigationInstruction?.maneuver ?? '';

                String instructionImage =
                    'assets/icons/head_direction.png';

                if (maneuver.toUpperCase().contains('LEFT')) {
                  instructionImage = 'assets/icons/left_direction.png';
                } else if (maneuver.toUpperCase().contains('RIGHT')) {
                  instructionImage = 'assets/icons/right_direction.png';
                }else{
                  instructionImage = 'assets/icons/right_direction.png';
                }

                return InstrucionCard(
                  instruction: instructionText,
                  instrucionDistance: "$instructionDistance M",
                  instructionImage: instructionImage,
                );
              },
            )
          else
            Center(child: CircularProgressIndicator(color: kPrimaryColor,)),

        ],
      ),
    ),
    Divider(color: Color(0xffE1E1E1),),
  ],
)
,
                backdropEnabled: false,
                parallaxEnabled: true,
              ),
              
              Container(
                height: 64,
                color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder:
                      (context, index) => SlidingPanelButton(
                        slidingPanelButtonModel: buttons[index],
                        onPressed: buttonsAction[index],
                      ),
                  itemCount: buttons.length,
                ),
              ),
            ],
          ),
        ],
      ),
      );
  }
 

  void initMapStyle()async{
    String style=await DefaultAssetBundle.of(context).loadString("assets/map_styles/map_style.json");
    mapStyle=style;
    setState(() {
      
    });
  }
  void toggleZoomLevel() {
    double zoomIn = 16;
    double zoomOut = 15;

    isZoomIn ? currentZoomLevel = zoomOut : currentZoomLevel = zoomIn;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(widget.originLocation.latitude, widget.originLocation.longitude),
          zoom: currentZoomLevel,
        ),
      ),
    );
    isZoomIn = !isZoomIn;
    setState(() {});
  }
  
    Future<List<LatLng>> getRouteData() async {
    LocationInfoModel origin = LocationInfoModel(
      location: LocationInfo(
        latLng: LatLngModel(
          latitude: widget.originLocation.latitude,
          longitude:widget. originLocation.longitude,
        ),
      ),
    );

    LocationInfoModel destination = LocationInfoModel(
      location: LocationInfo(
        latLng: LatLngModel(
          latitude:  distinationLocation.latitude,
          longitude:distinationLocation.longitude,
        ),
      ),
    );


     fetchedRoutes = await fetchRoutesService.fetchRoutesService(
      origin: origin,
      distination: destination,
    );
    
    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> points = getDecodedRoutes(polylinePoints, fetchedRoutes!);
    return points;
  }

  
List<LatLng> getDecodedRoutes(
  PolylinePoints polylinePoints,
   FullRoutesDataModel routes,
) {
 
  if (widget.filterType == "Best RQI (Quality)") {
    selectedRoute = routes.routes!.first;
  } else if (widget.filterType == "Shortest Path") {
    selectedRoute = routes.routes!
        .reduce((value, element) =>
            (element.distanceMeters ?? 0) < (value.distanceMeters ?? 0)
                ? element
                : value);
  } else {

    selectedRoute = routes.routes!.first;
  }

  List<PointLatLng> result = polylinePoints.decodePolyline(
    selectedRoute!.polyline!.encodedPolyline!,
  );

  List<LatLng> points =
      result.map((e) => LatLng(e.latitude, e.longitude)).toList();
      fullRoutePoints = points;

  return points;
}

  void displaypoints(List<LatLng> points) async{
     initMarkers();
    polylines.clear();
    allPolylines.clear();

    Polyline mainRoute = Polyline(
      polylineId: PolylineId("route"),
      points: points,
      color: Colors.green,
      width: 5,
    );
    polylines.add(mainRoute);
    allPolylines.add(mainRoute);

    math.Random random = math.Random();
    List<Color> warningColors = [Colors.red, Colors.orange];
    int maxWarnings = 5;
    int addedWarnings = 0;

    Set<int> usedIndices = {};
    Color? lastColor;

    while (addedWarnings < maxWarnings) {
      int index = random.nextInt(points.length - 2) + 1;

      if (usedIndices.contains(index)) continue;
      bool tooClose = usedIndices.any((i) => (i - index).abs() <= 2);
      if (tooClose) continue;

      usedIndices.add(index);

      LatLng start = points[index];
      LatLng end = points[index + 1];

      List<Color> possibleColors =
          warningColors.where((c) => c != lastColor).toList();
      Color selectedColor =
          possibleColors[random.nextInt(possibleColors.length)];
      lastColor = selectedColor;

      Polyline coloredLine = Polyline(
        polylineId: PolylineId("warning_$addedWarnings"),
        points: [start, end],
        color: selectedColor,
        width: 5,
      );

      polylines.add(coloredLine);
      allPolylines.add(coloredLine);

      addedWarnings++;
    }

    LatLngBounds bounds = getLatLngBounds(points);
    googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 60));

    setState(() {});
  }
   void loadCustomMarker() async {
  

    originMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      'assets/icons/origin_marker.png',
    );

    destinationMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      'assets/icons/distination_Marker.png',
    );
  }
  void initMarkers() {
Marker originMarker=Marker(markerId:MarkerId( "origin"),position: widget.originLocation,icon: originMarkerIcon);
Marker distinationMarker=Marker(markerId: MarkerId("distination"),position: distinationLocation,icon: destinationMarkerIcon);
markers.addAll([originMarker,distinationMarker]);
setState(() {
  
});
  }

}


