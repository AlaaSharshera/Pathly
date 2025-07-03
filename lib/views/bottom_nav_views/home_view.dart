import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/cubits/filter_cubit.dart';
import 'package:pathly/cubits/map_details_cubit/map_details_cubit.dart';
import 'package:pathly/cubits/map_type_cubit/map_type_cubit.dart';
import 'package:pathly/models/full_routes_data_model/full_routes_data_model.dart';
import 'package:pathly/models/location_info/lat_lng.dart';
import 'package:pathly/models/location_info/location.dart';
import 'package:pathly/models/location_info/location_info.dart';
import 'package:pathly/models/places_details/places_details_model.dart';
import 'package:pathly/models/road_condition/road_condition.dart';
import 'package:pathly/services/fetch_routes_service_class.dart';
import 'package:pathly/services/google_maps_places_service.dart';
import 'package:pathly/services/road_conditions_service.dart';
import 'package:pathly/utils/api_keys.dart';
import 'package:pathly/utils/calculate_distance.dart';
import 'package:pathly/utils/get_color.dart';
import 'package:pathly/utils/get_latlng_bounds.dart';
import 'package:pathly/utils/get_projection_on_segment.dart';
import 'package:pathly/utils/location_service.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/views/bottom_nav_views/search_view.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_search_textfield.dart';
import 'package:pathly/widgets/build_selctable_image.dart';
import 'package:pathly/widgets/dialog_card.dart';
import 'package:pathly/widgets/directions_button.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late CameraPosition initialCameraPosition;
  late GoogleMapController googleMapController;
  double currentZoomLevel = 11;
  bool isZoomIn = false;
  MapType googleMapType = MapType.normal;
  String? selectedMapDetail;
  late LocationService locationService;
  late TextEditingController controller;
  late GoogleMapsPlacesService googleMapsPlacesService;
  late FetchRoutesServiceClass fetchRoutesService;
  late BitmapDescriptor customIcon;
  bool isFirstView = true;
  Set<Marker> markers = {};
  late PlacesDetailsModel placesDetailsModel;
  late LatLng originLocation;
  LatLng? distinationLocation;
  List<RoadCondition> roadcondition = [];
  Set<Polyline> polylines = {};
  late BitmapDescriptor originMarkerIcon;
  late BitmapDescriptor destinationMarkerIcon;
  List<LatLng> fullRoutePoints = [];
  bool isArrived = false;
  String distinationName = '';
  List<Polyline> allPolylines = [];
  Set<Polyline> activePolylines = {};
 String mapStyle='';
  @override
  void initState() {
    initMapStyle();
    loadCustomMarker();
    googleMapsPlacesService = GoogleMapsPlacesService();
    locationService = LocationService();
    fetchRoutesService = FetchRoutesServiceClass();
    initialCameraPosition = CameraPosition(
      target: LatLng(31.4368, 31.667),
      zoom: currentZoomLevel,
    );
    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: 
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            GoogleMap(
               // style: mapStyle,
                  style: googleMapType == MapType.normal ? mapStyle : null,
              zoomGesturesEnabled: true,
              trafficEnabled: selectedMapDetail == "Traffic",
              polylines: polylines,
              markers: markers,
              zoomControlsEnabled: false,
              
              mapType: googleMapType,
              initialCameraPosition: initialCameraPosition,
              onMapCreated: (controller) {
                googleMapController = controller;
                setMyLocation();
              },
            ),

            //CustomLocationCard(distinationName: distinationName,),
            Positioned(
              top: 20,
              right: 0,
              left: 0,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContributeSearchTextField(
                    color: Colors.white,
                    onTap: () {
                      Get.to(
                        () => 
                        
                        
                        
                         BlocProvider<FilterCubit>(
        create: (context) => FilterCubit(),child:SearchView(
          originLocation: originLocation,
                          onLocationSelected: (placeModel) async {
                            placesDetailsModel = placeModel;
                            distinationName = placesDetailsModel.name!;
                            distinationLocation = LatLng(
                              placesDetailsModel.geometry!.location!.lat!,
                              placesDetailsModel.geometry!.location!.lng!,
                            );

                            // var points = await getRouteData();
                            //   displaypoints(points);

                            // roadcondition = await RoadConditionService()
                            //     .roadConditionService(
                            //       token: ApiKeys.token,
                            //       startLatitude: originLocation.latitude,
                            //       startLongitude: originLocation.longitude,
                            //       endLongitude: distinationLocation!.longitude,
                            //       endLatitude: distinationLocation!.latitude,
                            //     );

                            //selectedMapDetail=="Road Condition"?drawPolyLines():displaypoints(points);
                            // log("test");
                            // log(points[0].latitude.toString());
                          

                            //  await handleRouteDrawing();
                            setState(() {});
                          },
                        ),
                      ));
                    },
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            barrierColor: Colors.black.withOpacity(0.7),
                            context: context,
                            builder:
                                (context) => Center(child: AccountDialogCard()),
                          );
                        },
                        child: Image.asset(
                          "assets/images/profile.png",
                          width: 50,
                        ),
                      ),

                      SizedBox(height: 24),
                      GestureDetector(
                        onTap: () {
                          final homeContext = context;
                          showModalBottomSheet(
                            context: context,
                            builder:
                                (context) => SizedBox(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Map Type",
                                              style:
                                                  Styles
                                                      .stylePrimaryColorbold18,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              icon: Icon(Icons.close),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        BlocBuilder<MapTypeCubit, MapType>(
                                          bloc:
                                              homeContext.read<MapTypeCubit>(),
                                          builder:
                                              (context, mapType) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  BuildSelctableImage(
                                                    text: "Default",
                                                    imagePath:
                                                        "assets/images/default_map.png",
                                                    isSelected:
                                                        homeContext
                                                            .read<
                                                              MapTypeCubit
                                                            >()
                                                            .mapType ==
                                                        MapType.normal,
                                                    onTap: () {
                                                      homeContext
                                                          .read<MapTypeCubit>()
                                                          .defaultMapType();
                                                          googleMapType= homeContext
                                                          .read<MapTypeCubit>()
                                                          .mapType;
                                                     
                                                      setState(() {});
                                                      log(
                                                        homeContext
                                                            .read<
                                                              MapTypeCubit
                                                            >()
                                                            .mapType.toString(),
                                                      );
                                                    },
                                                  ),
                                                  BuildSelctableImage(
                                                    text: "Satellite",
                                                    imagePath:
                                                        "assets/images/satellite_map.png",
                                                    isSelected:
                                                        homeContext
                                                            .read<
                                                              MapTypeCubit
                                                            >()
                                                            .mapType ==
                                                        MapType.hybrid,
                                                    onTap: () {
                                                      homeContext
                                                          .read<MapTypeCubit>()
                                                          .hybridMapType();

                                                      googleMapType =
                                                          MapType.hybrid;
                                                      setState(() {});
                                                      log(
                                                        homeContext
                                                            .read<
                                                              MapTypeCubit
                                                            >()
                                                            .mapType.toString(),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                        ),
                                        SizedBox(height: 25),
                                        Align(
                                          alignment: Alignment.topLeft,
                                          child: Text(
                                            "Map Details",
                                            style:
                                                Styles.stylePrimaryColorbold18,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        BlocBuilder<MapDetailsCubit, String>(
                                          bloc:
                                              homeContext
                                                  .read<MapDetailsCubit>(),
                                          builder: (context, roadcondition) {
                                            return Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                BuildSelctableImage(
                                                  text: "Road Condition",
                                                  imagePath:
                                                      "assets/images/road_condition.png",
                                                  isSelected:
                                                      homeContext
                                                          .read<
                                                            MapDetailsCubit
                                                          >()
                                                          .mapDetails ==
                                                      "Road Condition",
                                                  onTap: () {
                                                    homeContext
                                                        .read<MapDetailsCubit>()
                                                        .roadConditionCase();
                                                    selectedMapDetail =
                                                        homeContext
                                                            .read<
                                                              MapDetailsCubit
                                                            >()
                                                            .mapDetails;
                                                    setState(() {});
                                                    log(
                                                      "selectedMapDetail is $selectedMapDetail",
                                                    );
                                                    log(
                                                      homeContext
                                                          .read<
                                                            MapDetailsCubit
                                                          >()
                                                          .mapDetails,
                                                    );
                                                  },
                                                ),
                                                BuildSelctableImage(
                                                  text: "Traffic",
                                                  imagePath:
                                                      "assets/images/traffic_map.png",
                                                  isSelected:
                                                      homeContext
                                                          .read<
                                                            MapDetailsCubit
                                                          >()
                                                          .mapDetails ==
                                                      "Traffic",
                                                  onTap: () {
                                                    homeContext
                                                        .read<MapDetailsCubit>()
                                                        .trafficCase();
                                                    selectedMapDetail =
                                                        homeContext
                                                            .read<
                                                              MapDetailsCubit
                                                            >()
                                                            .mapDetails;
                                                    setState(() {});
                                                    log(
                                                      "selectedMapDetail is $selectedMapDetail",
                                                    );
                                                    log(
                                                      homeContext
                                                          .read<
                                                            MapDetailsCubit
                                                          >()
                                                          .mapDetails,
                                                    );
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          );
                        },

                        child: SvgPicture.asset(
                          "assets/icons/edit_map.svg",
                          height: 50,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              right: 20,
              bottom: 50,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      toggleZoomLevel();
                    },
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

                  DirectionButton(
                    onTap: () {
                      log(context.read<MapTypeCubit>().mapType.toString());

                      log(context.read<MapDetailsCubit>().mapDetails);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setMyLocationMarker(LocationData locationData) {
    LatLng currentPos = LatLng(locationData.latitude!, locationData.longitude!);

    if (distinationLocation != null && !isArrived) {
      double distanceToDestination = calculateDistance(
        currentPos.latitude,
        currentPos.longitude,
        distinationLocation!.latitude,
        distinationLocation!.longitude,
      );

      if (distanceToDestination < 0.01) {
        markers.removeWhere((marker) => marker.markerId == MarkerId("origin"));
        polylines.clear();
        isArrived = true;
        setState(() {});
        return;
      }
    }

    if (isArrived) return;

    markers.removeWhere((marker) => marker.markerId == MarkerId("origin"));
    final iconToUse =
        distinationLocation == null ? customIcon : originMarkerIcon;

    Marker currentLocationMarker = Marker(
      markerId: MarkerId("origin"),
      position: currentPos,
      icon: iconToUse,
    );
    markers.add(currentLocationMarker);

    if (fullRoutePoints.length >= 2 && distinationLocation != null) {
      
      double minDistance = double.infinity;
      LatLng bestProjection = fullRoutePoints[0];
      int bestSegmentIndex = 0;

      for (int i = 0; i < fullRoutePoints.length - 1; i++) {
        LatLng a = fullRoutePoints[i];
        LatLng b = fullRoutePoints[i + 1];
        LatLng projection = getProjectionOnSegment(currentPos, a, b);

        double distance = calculateDistance(
          currentPos.latitude,
          currentPos.longitude,
          projection.latitude,
          projection.longitude,
        );

        if (distance < minDistance) {
          minDistance = distance;
          bestProjection = projection;
          bestSegmentIndex = i;
        }
      }

      polylines.clear();

      for (var polyline in allPolylines) {
        if (polyline.polylineId.value == "route") {
         
          List<LatLng> trimmed = [
            bestProjection,
            ...fullRoutePoints.sublist(bestSegmentIndex + 1),
          ];
          polylines.add(
            Polyline(
              polylineId: polyline.polylineId,
              points: trimmed,
              color: polyline.color,
              width: polyline.width,
            ),
          );
        } else {
       

          List<LatLng> points = polyline.points;
          LatLng a = points.first;
          LatLng b = points.last;

         
          LatLng projection = getProjectionOnSegment(currentPos, a, b);

        
          double segLength = calculateDistance(
            a.latitude,
            a.longitude,
            b.latitude,
            b.longitude,
          );
          double projDist = calculateDistance(
            a.latitude,
            a.longitude,
            projection.latitude,
            projection.longitude,
          );
          double endDist = calculateDistance(
            b.latitude,
            b.longitude,
            projection.latitude,
            projection.longitude,
          );

          bool isInsideSegment = projDist + endDist - segLength < 0.001;

          if (isInsideSegment) {
         
            if (endDist > 0.001) {
              polylines.add(
                Polyline(
                  polylineId: polyline.polylineId,
                  points: [projection, b],
                  color: polyline.color,
                  width: polyline.width,
                ),
              );
            }
            
          } else {
           
            polylines.add(polyline);
          }
        }
      }
    }

    setState(() {});
  }

  void setMyLocation() async {
    locationService.getRealTimeLocatin(
      onData: (locationData) {
        originLocation = LatLng(
          locationData.latitude!,
          locationData.longitude!,
        );
        setMyLocationMarker(locationData);
        setNewCameraPosition(locationData);
      },
    );
  }

  void setNewCameraPosition(LocationData locationData) {
    if (isFirstView) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: 14,
      );
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(cameraPosition),
      );
      isFirstView = false;
    } else {
      googleMapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(locationData.latitude!, locationData.longitude!),
        ),
      );
    }
  }

  void toggleZoomLevel() {
    double zoomIn = 16;
    double zoomOut = 11;

    isZoomIn ? currentZoomLevel = zoomOut : currentZoomLevel = zoomIn;
    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(originLocation.latitude, originLocation.longitude),
          zoom: currentZoomLevel,
        ),
      ),
    );
    isZoomIn = !isZoomIn;
    setState(() {});
  }

  void loadCustomMarker() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      'assets/icons/marker.png',
    );

    originMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      'assets/icons/origin_marker.png',
    );

    destinationMarkerIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(50, 50)),
      'assets/icons/distination_Marker.png',
    );
  }
 void initMapStyle()async{
    String style=await DefaultAssetBundle.of(context).loadString("assets/map_styles/map_style.json");
    mapStyle=style;
    setState(() {
      
    });
  }
  Future<List<LatLng>> getRouteData() async {
    LocationInfoModel origin = LocationInfoModel(
      location: LocationInfo(
        latLng: LatLngModel(
          latitude: originLocation.latitude,
          longitude: originLocation.longitude,
        ),
      ),
    );

    LocationInfoModel destination = LocationInfoModel(
      location: LocationInfo(
        latLng: LatLngModel(
          latitude: distinationLocation!.latitude,
          longitude: distinationLocation!.longitude,
        ),
      ),
    );

    markers.removeWhere((marker) => marker.markerId == MarkerId("destination"));

    Marker destinationMarker = Marker(
      markerId: MarkerId("destination"),
      position: LatLng(
        destination.location!.latLng!.latitude!,
        destination.location!.latLng!.longitude!,
      ),
      icon: destinationMarkerIcon,
    );
    markers.add(destinationMarker);

    markers.removeWhere((marker) => marker.markerId == MarkerId("origin"));
    Marker updatedOriginMarker = Marker(
      markerId: MarkerId("origin"),
      position: LatLng(originLocation.latitude, originLocation.longitude),
      icon: originMarkerIcon,
    );
    markers.add(updatedOriginMarker);

    setState(() {});

    FullRoutesDataModel routes = await fetchRoutesService.fetchRoutesService(
      origin: origin,
      distination: destination,
    );

    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> points = getDecodedRoutes(polylinePoints, routes);

    fullRoutePoints = points;
    isArrived = false;
    return points;
  }

  


  List<LatLng> getDecodedRoutes(
    PolylinePoints polylinePoints,
    FullRoutesDataModel routes,
  ) {
    List<PointLatLng> result = polylinePoints.decodePolyline(
      //routes.routes!.first.polyline!.encodedPolyline!,
      routes.routes![0].polyline!.encodedPolyline!
    );

    List<LatLng> points =
        result.map((e) => LatLng(e.latitude, e.longitude)).toList();
    return points;
  }

  void displaypoints(List<LatLng> points) {
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
    googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 40));

    setState(() {});
  }


  void drawPolyLines() {
    polylines.clear();

    LatLng? lastEndPoint;
    List<LatLng> allPoints = [];

    for (int i = 0; i < roadcondition.length; i++) {
      final condition = roadcondition[i];
      final color = getColorFromString(condition.color ?? 'green');

      if (condition.points != null && condition.points!.isNotEmpty) {
        List<LatLng> latLngPoints =
            condition.points!
                .map((point) => LatLng(point.latitude!, point.longitude!))
                .toList();

        if (lastEndPoint != null) {
          latLngPoints.insert(0, lastEndPoint);
        }

        lastEndPoint = latLngPoints.last;
        allPoints.addAll(latLngPoints);

        Polyline polyline = Polyline(
          width: 7,
          polylineId: PolylineId("polyline_$i"),
          color: color,
          points: latLngPoints,
        );

        polylines.add(polyline);
      }
    }

    if (lastEndPoint != null && distinationLocation != null) {
      final LatLng destinationLatLng = LatLng(
        distinationLocation!.latitude,
        distinationLocation!.longitude,
      );

      if (lastEndPoint.latitude != destinationLatLng.latitude ||
          lastEndPoint.longitude != destinationLatLng.longitude) {
        List<LatLng> remainingPath = [lastEndPoint, destinationLatLng];
        allPoints.addAll(remainingPath);

        Polyline remainingPolyline = Polyline(
          width: 7,
          polylineId: PolylineId("polyline_remaining"),
          color: Colors.green,
          points: remainingPath,
        );

        polylines.add(remainingPolyline);
      }
    }

    if (allPoints.isNotEmpty) {
      LatLngBounds bounds = getLatLngBounds(allPoints);
      googleMapController.animateCamera(
        CameraUpdate.newLatLngBounds(bounds, 40),
      );
    }

    setState(() {});
  }


}
