import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pathly/models/full_routes_data_model/route.dart';
import 'package:pathly/utils/calculate_distance.dart';
import 'package:pathly/utils/format_distance.dart';
import 'package:pathly/utils/format_time.dart';
import 'package:pathly/utils/get_projection_on_segment.dart';
import 'package:pathly/utils/location_service.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/rqi_widget.dart';
import 'package:intl/intl.dart';

class StartTripView extends StatefulWidget {
  const StartTripView({    required this.originLocation,
    required this.destinationLocation,
    required this.fullRoutePoints,
    required this.allPolylines,
    required this.selectedRoute,super.key});
  final LatLng originLocation;
  final LatLng destinationLocation;
  final List<LatLng> fullRoutePoints;
  final List<Polyline> allPolylines;
  final RouteModel selectedRoute;
  
  @override
  State<StartTripView> createState() => _StartTripViewState();
}

class _StartTripViewState extends State<StartTripView> {
  late GoogleMapController googleMapController;
  double currentZoomLevel = 11;
  bool isZoomIn = false;
  BitmapDescriptor? originMarkerIcon;
  BitmapDescriptor? destinationMarkerIcon;
  String mapStyle = '';
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  late String formattedTime;
  late LatLng originLocation;
  late LocationService locationService;
  late final LatLng distinationLocation;
  late final List<LatLng> fullRoutePoints;
  late final List<Polyline> allPolylines;
  late final RouteModel selectedRoute;
  Set<Polyline> warningPolylines = {};
  Polyline? mainRoutePolyline;
  bool isArrived = false;
  bool showDialog = true;

  @override
  void initState() {
    super.initState();
    locationService = LocationService();
    originLocation = widget.originLocation;
    distinationLocation = widget.destinationLocation;
    fullRoutePoints = widget.fullRoutePoints;
    allPolylines = widget.allPolylines;
    selectedRoute = widget.selectedRoute;

    for (var poly in allPolylines) {
      if (poly.polylineId.value == "route") {
        mainRoutePolyline = poly; 
      } else {
        warningPolylines.add(poly); 
      }
    }

    final currentTime = DateTime.now();
    formattedTime = DateFormat('h:mm a').format(currentTime).toLowerCase();

    loadCustomMarker();
    initMapStyle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            style: mapStyle,
            markers: markers,
            polylines: polylines,
            zoomControlsEnabled: false,
         onMapCreated: (controller) async {
  googleMapController = controller;

  polylines.clear();

  
  for (var poly in allPolylines) {
    polylines.add(poly);
  }

  initMarkers();
  setMyLocation();

  setState(() {}); 
},

            initialCameraPosition: CameraPosition(
              target:  widget.originLocation,
              zoom: 15,
            ),
          ),

               Positioned(
        top: 159,
        left: 32,
        child: Container(
          height: 56,
          width: 131,
          decoration: BoxDecoration(
            color: Color(0xff019C4C),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.turn_right, color: Colors.white,size: 34),
                SizedBox(width: 8),
                Text("Then", style: Styles.styleWhiteBold22),
              ],
            ),
          ),
        ),
      ),
     
      Positioned(
        top: 70,
        left: 32,
        right: 32,
        child: Container(
          height: 90,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xff019C4C),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: Offset(0, 4), 
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.arrow_upward, color: Colors.white,size: 34,),
              SizedBox(width: 12),
              Text("Head Southeast", style: Styles.styleWhiteBold22),
            ],
          ),
        ),
      ),
          Positioned(
            bottom: 0,
            child: showDialog
                ? Container(
                    alignment: Alignment.centerLeft,
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xff1E1E1E),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 55,
                          width: 55,
                          margin: EdgeInsets.only(left: 32, right: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Colors.white),
                          ),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                showDialog = false;
                              });
                            },
                            icon: Icon(Icons.close,
                                color: Colors.white, size: 30),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              formatDuration(selectedRoute.duration),
                              style: GoogleFonts.poppins(
                                color: Color(0xff019C4C),
                                fontWeight: FontWeight.w500,
                                fontSize: 28,
                              ),
                            ),
                            Text(
                              "${formatDistance(selectedRoute.distanceMeters)}  $formattedTime",
                              style: Styles.stylegrey16,
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : SizedBox(),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: RqiWidget(alignment: Alignment.centerLeft),
          ),
        ],
      ),
    );
  }

  void initMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString("assets/map_styles/map_style.json");
    setState(() {
      mapStyle = style;
    });
  }

  void toggleZoomLevel() {
    double zoomIn = 16;
    double zoomOut = 15;

    isZoomIn ? currentZoomLevel = zoomOut : currentZoomLevel = zoomIn;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: originLocation,
          zoom: currentZoomLevel,
        ),
      ),
    );

    setState(() {
      isZoomIn = !isZoomIn;
    });
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

    setState(() {});
  }

  void setMyLocation() async {
  locationService.getRealTimeLocatin(
    onData: (locationData) {
      setMyLocationMarker(locationData);
    },
  );
}


  void setNewCameraPosition(LocationData locationData) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude!, locationData.longitude!),
      zoom: 15,
    );
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );
  }

  void initMarkers() {
    if (originMarkerIcon == null || destinationMarkerIcon == null) return;

    Marker originMarker = Marker(
      markerId: MarkerId("origin"),
      position: originLocation,
      icon: originMarkerIcon!,
    );

    Marker destinationMarker = Marker(
      markerId: MarkerId("destination"),
      position: distinationLocation,
      icon: destinationMarkerIcon!,
    );

    markers.addAll([originMarker, destinationMarker]);

    setState(() {});
  }

  
  void setMyLocationMarker(LocationData locationData) {
  if (fullRoutePoints.isEmpty) return;

  LatLng currentPos = LatLng(locationData.latitude!, locationData.longitude!);

  if (!isArrived) {
    double distanceToDestination = calculateDistance(
      currentPos.latitude,
      currentPos.longitude,
      distinationLocation.latitude,
      distinationLocation.longitude,
    );
    if (distanceToDestination < 0.01) {
      markers.removeWhere((m) => m.markerId == MarkerId("origin"));
      polylines.clear();
      isArrived = true;
      setState(() {});
      return;
    }
  }

  if (isArrived) return;

  markers.removeWhere((m) => m.markerId == MarkerId("origin"));
  markers.add(Marker(
    markerId: MarkerId("origin"),
    position: currentPos,
    icon: originMarkerIcon!,
  ));

  markers.removeWhere((m) => m.markerId == MarkerId("destination"));
  markers.add(Marker(
    markerId: MarkerId("destination"),
    position: distinationLocation,
    icon: destinationMarkerIcon!,
  ));

  double minDistance = double.infinity;
  LatLng bestProjection = fullRoutePoints[0];
  int bestSegmentIndex = 0;

  for (int i = 0; i < fullRoutePoints.length - 1; i++) {
    LatLng a = fullRoutePoints[i];
    LatLng b = fullRoutePoints[i + 1];
    LatLng projection = getProjectionOnSegment(currentPos, a, b);

    double distance = calculateDistance(
      currentPos.latitude, currentPos.longitude,
      projection.latitude, projection.longitude);

    if (distance < minDistance) {
      minDistance = distance;
      bestProjection = projection;
      bestSegmentIndex = i;
    }
  }

  polylines.clear();

  if (mainRoutePolyline != null) {
    polylines.add(Polyline(
      polylineId: mainRoutePolyline!.polylineId,
      points: [bestProjection, ...fullRoutePoints.sublist(bestSegmentIndex + 1)],
      color: mainRoutePolyline!.color,
      width: mainRoutePolyline!.width,
    ));
  }


  for (var warning in warningPolylines) {
    if (warning.points.length < 2) continue;

    LatLng a = warning.points.first;
    LatLng b = warning.points.last;

    LatLng projection = getProjectionOnSegment(currentPos, a, b);

    double segLength = calculateDistance(a.latitude, a.longitude, b.latitude, b.longitude);
    double distToProj = calculateDistance(a.latitude, a.longitude, projection.latitude, projection.longitude);
    double distToEnd = calculateDistance(b.latitude, b.longitude, projection.latitude, projection.longitude);

    bool isInsideSegment = (distToProj + distToEnd - segLength).abs() < 0.001;

    if (isInsideSegment && distToEnd > 0.005) {
      polylines.add(Polyline(
        polylineId: warning.polylineId,
        points: [projection, b],
        color: warning.color,
        width: warning.width,
      ));
    }
  }

  setState(() {});
}

}