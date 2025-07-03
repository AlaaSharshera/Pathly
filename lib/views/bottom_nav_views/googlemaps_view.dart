// import 'dart:developer';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:pathly/constant.dart';
// import 'package:pathly/models/location_info/lat_lng.dart';
// import 'package:pathly/models/location_info/location.dart';
// import 'package:pathly/models/location_info/location_info.dart';
// import 'package:pathly/models/places_details/places_details_model.dart';
// import 'package:pathly/models/road_condition/road_condition.dart';
// import 'package:pathly/models/rotes_model/routes_model.dart';
// import 'package:pathly/services/fetch_routes_service_class.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import 'package:pathly/services/google_maps_places_service.dart';
// import 'package:pathly/services/road_conditions_service.dart';
// import 'package:pathly/utils/location_service.dart';
// import 'package:pathly/views/bottom_nav_views/search_view.dart';
// import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_search_textfield.dart';

// class GooglemapsView extends StatefulWidget {
//   const GooglemapsView({super.key});

//   @override
//   State<GooglemapsView> createState() => _GooglemapsViewState();
// }

// class _GooglemapsViewState extends State<GooglemapsView> {
//   late GoogleMapController googleMapController;
//   late CameraPosition initialCameraPosition;
//   late LocationService locationService;
//   late TextEditingController controller;
//   late GoogleMapsPlacesService googleMapsPlacesService;
//   late FetchRoutesServiceClass fetchRoutesService;
//   late BitmapDescriptor customIcon;
//   bool isFirstView = true;
//   Set<Marker> markers = {};
//   late PlacesDetailsModel placesDetailsModel;
//   late LatLng originLocation;
//   LatLng? distinationLocation;
//   Set<Polyline> polylines = {};

//   @override
//   void initState() {
//     loadCustomMarker();
//     initialCameraPosition = CameraPosition(
//       target: LatLng(31.4368, 31.6670),
//       zoom: 9,
//     );
//     controller = TextEditingController();
//     googleMapsPlacesService = GoogleMapsPlacesService();

//     locationService = LocationService();
//     fetchRoutesService = FetchRoutesServiceClass();
//     //setMyLocation();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     googleMapController.dispose();
//     controller.dispose();
//     super.dispose();
//   }
//   void loadCustomMarker() async {
//   customIcon = await BitmapDescriptor.fromAssetImage(
//     const ImageConfiguration(size: Size(50,50)), // تقدرِ تغيري الحجم لو حابة
//     'assets/icons/marker.png',
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         body: Stack(
//           children: [
//             GoogleMap(
//               polylines: polylines,
//               markers: markers,
//               onMapCreated: (controller) {
//                 googleMapController = controller;
//                 allocateLocation();
//               },
//               zoomControlsEnabled: false,
//               initialCameraPosition: initialCameraPosition,
//             ),
//             Positioned(
//               top: 20,
//               right: 0,
//               left: 0,
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   CustomContributeSearchTextField(
//                     color: Colors.white,
//                     onTap: () {
//                       Get.to(
//                         () => SearchView(
//                           onLocationSelected: (placeModel) async {
//                             placesDetailsModel = placeModel;
//                             distinationLocation = LatLng(
//                               placesDetailsModel.geometry!.location!.lat!,
//                               placesDetailsModel.geometry!.location!.lng!,
//                             );
//                             setState(() {});
//                             var points = await getRouteData();

//                             List<RoadCondition>roadcondition= await RoadConditionService().roadConditionService(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIzIiwianRpIjoiOTYyODRkZWItNWFlMS00MTAxLWEwYjktODUxZDUyMWYyMjc3IiwiZW1haWwiOiJhbGFhc0BnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjMiLCJpc0FkbWluIjoiVHJ1ZSIsImV4cCI6MTc0ODI5NDYwNywiaXNzIjoiU2VjdXJlQXBpIiwiYXVkIjoiU2VjdXJlQXBpVXNlciJ9.GASG3PN9w9F-07kME1R7dkdcqIVcL9wEoPjBOMnQHPo", startLatitude:  31.43496067, startLongitude:  31.67756983, endLongitude: 31.45252233, endLatitude: 31.68269767);
//                             print(roadcondition[0].clusterName.toString());
//                             displaypoints(points);
//                           },
//                         ),
//                       );
//                     },
//                   ),
//                   Column(
//                     children: [
//                       Image.asset("assets/images/profile.png", width: 50),
//                       SizedBox(height: 24),
//                       GestureDetector(
//                         onTap: ()async {

//                           // showBottomSheet(
//                           //   context: context,
//                           //   builder:
//                           //       (context) => Positioned(
//                           //         bottom: 0,
//                           //         child: BottomSheet(
//                           //           onClosing: () {},
//                           //           builder: (context) => Text("data"),
//                           //         ),
//                           //       ),
//                           // );
//                           // log(placesDetailsModel.geometry!.location!.lat.toString());
//                         },
//                         child: SvgPicture.asset("assets/icons/edit_map.svg",height: 50,),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Positioned(
//               right: 20,
//               bottom: 50,
//               child: Column(
//                 children: [
//                   CircleAvatar(
//                     backgroundColor: Colors.white,
//                     child: SvgPicture.asset("assets/icons/focus.svg"),
//                   ),

//                   Container(
//                     width: 40,
//                     height: 40,
//                     margin: EdgeInsets.only(top: 20),
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       color: kPrimaryColor,
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: SvgPicture.asset("assets/icons/directions.svg"),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void setMyLocationMarker(LocationData locationData) {
//     Marker trackLocationMarker = Marker(
//       icon: customIcon,
//       markerId: MarkerId("Track Location"),
//       position: LatLng(locationData.latitude!, locationData.longitude!),
//     );

//     markers.add(trackLocationMarker);
//     setState(() {});
//   }

//   void allocateLocation() async {
//     LocationData allocatedLocation = await locationService.getLocation();
//     originLocation = LatLng(
//       allocatedLocation.latitude!,
//       allocatedLocation.longitude!,
//     );
//     if (isFirstView) {
//       googleMapController.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: originLocation, zoom: 12),
//         ),
//       );
//       setMyLocationMarker(allocatedLocation);
//       setState(() {});
//       isFirstView = false;
//     } else {
//       googleMapController.animateCamera(
//         CameraUpdate.newLatLng(
//           LatLng(allocatedLocation.latitude!, allocatedLocation.longitude!),
//         ),
//       );
//     }
//   }

//   Future<List<LatLng>> getRouteData() async {
//     LocationInfoModel origin = LocationInfoModel(
//       location: LocationInfo(
//         latLng: LatLngModel(
//           latitude: originLocation.latitude,
//           longitude: originLocation.longitude,
//         ),
//       ),
//     );
//     LocationInfoModel distination = LocationInfoModel(
//       location: LocationInfo(
//         latLng: LatLngModel(
//           latitude: distinationLocation!.latitude,
//           longitude: distinationLocation!.longitude,
//         ),
//       ),
//     );
//     RoutesModel routes = await fetchRoutesService.fetchRoutesService(
//       origin: origin,
//       distination: distination,
//     );

//     PolylinePoints polylinePoints = PolylinePoints();
//     List<LatLng> points = getDecodedRoutes(polylinePoints, routes);
//     return points;
//   }

//   List<LatLng> getDecodedRoutes(
//     PolylinePoints polylinePoints,
//     RoutesModel routes,
//   ) {
//     List<PointLatLng> result = polylinePoints.decodePolyline(
//       routes.routes!.first.polyline!.encodedPolyline!,
//     );
//     List<LatLng> points =
//         result.map((e) => LatLng(e.latitude, e.longitude)).toList();
//     return points;
//   }

//   void displaypoints(List<LatLng> points) {
//     Polyline route = Polyline(
//       polylineId: PolylineId("route"),
//       points: points,
//       color: Colors.blue,
//       width: 5,
//     );
//     polylines.add(route);
//     LatLngBounds bounds = getLatLngBounds(points);

//     googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 32));
//     setState(() {});
//   }

//   LatLngBounds getLatLngBounds(List<LatLng> points) {
//     var southWestLatitude = points.first.latitude;
//     var southWestLongtiude = points.first.longitude;
//     var nourthEastLatiude = points.first.latitude;
//     var nourthEastLongtiude = points.first.longitude;
//     for (var point in points) {
//       southWestLatitude = min(southWestLatitude, point.latitude);
//       southWestLongtiude = min(southWestLongtiude, point.longitude);
//       nourthEastLatiude = max(nourthEastLatiude, point.latitude);
//       nourthEastLongtiude = max(nourthEastLongtiude, point.longitude);
//     }
//     LatLng southwest = LatLng(southWestLatitude, southWestLongtiude);
//     LatLng northeast = LatLng(nourthEastLatiude, nourthEastLongtiude);
//     return LatLngBounds(southwest: southwest, northeast: northeast);
//   }
// }

// void setMyLocation() async{
// locationService.getRealTimeLocatin(onData: (locationData){

//    setMyLocationMarker(locationData);
//    setNewCameraPosition(locationData);
// });

// }

//   void setNewCameraPosition(LocationData locationData) {

//          if(isFirstView){
//           CameraPosition cameraPosition=CameraPosition(target: LatLng(locationData.latitude!, locationData.longitude!),zoom: 14);
//  googleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
//  isFirstView=false;
//          }else{
//            googleMapController.animateCamera(CameraUpdate.newLatLng(LatLng(locationData.latitude!, locationData.longitude!)));
//          }
// //   }

//   void setMyLocationMarker(LocationData locationData) {
//     Marker trackLocationMarker = Marker(
//       markerId: const MarkerId("Track Location"),
//       position: LatLng(locationData.latitude!, locationData.longitude!),
//     );

//     markers.add(trackLocationMarker);
//     setState(() {});
//   }

//   void allocateLocation() async {
//     LocationData allocatedLocation = await locationService.getLocation();

//     googleMapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: LatLng(
//             allocatedLocation.latitude!,
//             allocatedLocation.longitude!,
//           ),
//           zoom: 12,
//         ),
//       ),
//     );

//     setMyLocationMarker(allocatedLocation);
//   }
// }}
//alaa

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pathly/constant.dart';
import 'package:pathly/models/full_routes_data_model/full_routes_data_model.dart';
import 'package:pathly/models/location_info/lat_lng.dart';
import 'package:pathly/models/location_info/location.dart';
import 'package:pathly/models/location_info/location_info.dart';
import 'package:pathly/models/places_details/places_details_model.dart';
import 'package:pathly/models/road_condition/road_condition.dart';
import 'package:pathly/services/fetch_routes_service_class.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:pathly/services/google_maps_places_service.dart';
import 'package:pathly/services/road_conditions_service.dart';
import 'package:pathly/utils/api_keys.dart';
import 'package:pathly/utils/get_color.dart';
import 'package:pathly/utils/location_service.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/views/bottom_nav_views/search_view.dart';
import 'package:pathly/widgets/bottom_nav_views_widgets/custom_contribute_search_textfield.dart';
import 'package:pathly/widgets/build_selctable_image.dart';
import 'package:pathly/widgets/dialog_card.dart';

class GooglemapsView extends StatefulWidget {
  const GooglemapsView({super.key});

  @override
  State<GooglemapsView> createState() => _GooglemapsViewState();
}

class _GooglemapsViewState extends State<GooglemapsView> {
  late GoogleMapController googleMapController;
  late CameraPosition initialCameraPosition;
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
  String? selectedMapType;
  String selectedMapDetail = "road";
  MapType googlemapType = MapType.normal;
  late BitmapDescriptor originMarkerIcon;
  late BitmapDescriptor destinationMarkerIcon;

  @override
  void initState() {
    loadCustomMarker();

    initialCameraPosition = CameraPosition(
      target: LatLng(31.4368, 31.6670),
      zoom: 9,
    );
    controller = TextEditingController();
    googleMapsPlacesService = GoogleMapsPlacesService();

    locationService = LocationService();
    fetchRoutesService = FetchRoutesServiceClass();
    //setMyLocation();

    super.initState();
  }

  @override
  void dispose() {
    googleMapController.dispose();
    controller.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              trafficEnabled: selectedMapDetail == "traffic",
              // myLocationEnabled: true,
              polylines: polylines,
              markers: markers,
              mapType: googlemapType,
              onMapCreated: (controller) {
                googleMapController = controller;
                allocateLocation();
              },
              zoomControlsEnabled: false,
              initialCameraPosition: initialCameraPosition,
            ),
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
                        () => SearchView(
                          originLocation: originLocation,
                          onLocationSelected: (placeModel) async {
                            placesDetailsModel = placeModel;
                            distinationLocation = LatLng(
                              placesDetailsModel.geometry!.location!.lat!,
                              placesDetailsModel.geometry!.location!.lng!,
                            );
                            setState(() {});
                            var points = await getRouteData();

                            roadcondition = await RoadConditionService()
                                .roadConditionService(
                                  token: ApiKeys.token,
                                  startLatitude: originLocation.latitude,
                                  startLongitude: originLocation.longitude,
                                  endLongitude: distinationLocation!.longitude,
                                  endLatitude: distinationLocation!.latitude,
                                );
                            //  print(roadcondition[0].clusterName.toString());
                            selectedMapDetail == "road"
                                ? drawPolyLines()
                                : displaypoints(points);

                            setState(() {});
                          },
                        ),
                      );
                    },
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                            context: context,
                            barrierColor: Colors.black.withOpacity(
                              0.3,
                            ), // شفافية الخلفية
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
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(0),
                              ),
                            ),
                            isScrollControlled: true,
                            builder: (context) {
                              return StatefulBuilder(
                                builder: (
                                  BuildContext context,
                                  StateSetter setModalState,
                                ) {
                                  selectedMapType ??= "default";
                                  selectedMapDetail ??= "road";

                                  return SizedBox(
                                    width: double.infinity,
                                    height:
                                        MediaQuery.of(context).size.height *
                                        0.5,
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
                                                  setState(() {});
                                                  Get.back();
                                                  print(selectedMapType);
                                                  print(selectedMapDetail);
                                                },
                                                icon: Icon(Icons.close),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BuildSelctableImage(
                                                text: "Default",
                                                imagePath:
                                                    "assets/images/default_map.png",
                                                isSelected:
                                                    selectedMapType ==
                                                    "default",
                                                onTap: () {
                                                  setModalState(() {
                                                    selectedMapType = "default";
                                                    googlemapType =
                                                        MapType.normal;
                                                    setState(() {});
                                                  });
                                                },
                                              ),
                                              BuildSelctableImage(
                                                imagePath:
                                                    "assets/images/satellite_map.png",
                                                text: "Satellite",
                                                isSelected:
                                                    selectedMapType ==
                                                    "satellite",
                                                onTap: () {
                                                  setModalState(() {
                                                    selectedMapType =
                                                        "satellite";
                                                    googlemapType =
                                                        MapType.hybrid;
                                                    setState(() {});
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 40),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Map Details",
                                              style:
                                                  Styles
                                                      .stylePrimaryColorbold18,
                                            ),
                                          ),
                                          SizedBox(height: 20),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              BuildSelctableImage(
                                                text: "Road Condition",
                                                imagePath:
                                                    "assets/images/road_condition.png",
                                                isSelected:
                                                    selectedMapDetail == "road",
                                                onTap: () {
                                                  setModalState(() {
                                                    selectedMapDetail = "road";
                                                  });
                                                },
                                              ),
                                              BuildSelctableImage(
                                                text: "Traffic",
                                                imagePath:
                                                    "assets/images/traffic_map.png",
                                                isSelected:
                                                    selectedMapDetail ==
                                                    "traffic",
                                                onTap: () {
                                                  setModalState(() {
                                                    selectedMapDetail =
                                                        "traffic";
                                                  });
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
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
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: SvgPicture.asset("assets/icons/focus.svg"),
                  ),

                  Container(
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset("assets/icons/directions.svg"),
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
    Marker trackLocationMarker = Marker(
      icon: customIcon,
      markerId: MarkerId("Track Location"),
      position: LatLng(locationData.latitude!, locationData.longitude!),
    );

    markers.add(trackLocationMarker);
    setState(() {});
  }

  void allocateLocation() async {
    LocationData allocatedLocation = await locationService.getLocation();
    originLocation = LatLng(
      allocatedLocation.latitude!,
      allocatedLocation.longitude!,
    );
    if (isFirstView) {
      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: originLocation, zoom: 14),
        ),
      );
      setMyLocationMarker(allocatedLocation);
      setState(() {});
      isFirstView = false;
    } else {
      googleMapController.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(allocatedLocation.latitude!, allocatedLocation.longitude!),
        ),
      );
    }
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

    Marker originMarker = Marker(
      markerId: MarkerId("origin"),
      position: LatLng(
        origin.location!.latLng!.latitude!,
        origin.location!.latLng!.longitude!,
      ),
      icon: originMarkerIcon,
    );

    LocationInfoModel destination = LocationInfoModel(
      location: LocationInfo(
        latLng: LatLngModel(
          latitude: distinationLocation!.latitude,
          longitude: distinationLocation!.longitude,
        ),
      ),
    );

    Marker destinationMarker = Marker(
      markerId: MarkerId("destination"),
      position: LatLng(
        destination.location!.latLng!.latitude!,
        destination.location!.latLng!.longitude!,
      ),
      icon: destinationMarkerIcon,
    );

    // أضف الماركرز إلى الخريطة
    markers.clear();
    markers.addAll([originMarker, destinationMarker]);
    setState(() {}); // لتحديث الخريطة بالمكانين

    // احصل على المسار
    FullRoutesDataModel routes = await fetchRoutesService.fetchRoutesService(
      origin: origin,
      distination: destination,
    );

    PolylinePoints polylinePoints = PolylinePoints();
    List<LatLng> points = getDecodedRoutes(polylinePoints, routes);

    return points;
  }

  List<LatLng> getDecodedRoutes(
    PolylinePoints polylinePoints,
    FullRoutesDataModel routes,
  ) {
    List<PointLatLng> result = polylinePoints.decodePolyline(
      routes.routes!.first.polyline!.encodedPolyline!,
    );

    List<LatLng> points =
        result.map((e) => LatLng(e.latitude, e.longitude)).toList();
    return points;
  }

  void displaypoints(List<LatLng> points) {
    polylines.clear();
    Polyline route = Polyline(
      polylineId: PolylineId("route"),
      points: points,
      color: Colors.blue,
      width: 5,
    );

    polylines.add(route);
    LatLngBounds bounds = getLatLngBounds(points);

    googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 20));
    setState(() {});
  }

  LatLngBounds getLatLngBounds(List<LatLng> points) {
    var southWestLatitude = points.first.latitude;
    var southWestLongtiude = points.first.longitude;
    var nourthEastLatiude = points.first.latitude;
    var nourthEastLongtiude = points.first.longitude;
    for (var point in points) {
      southWestLatitude = min(southWestLatitude, point.latitude);
      southWestLongtiude = min(southWestLongtiude, point.longitude);
      nourthEastLatiude = max(nourthEastLatiude, point.latitude);
      nourthEastLongtiude = max(nourthEastLongtiude, point.longitude);
    }
    LatLng southwest = LatLng(southWestLatitude, southWestLongtiude);
    LatLng northeast = LatLng(nourthEastLatiude, nourthEastLongtiude);
    return LatLngBounds(southwest: southwest, northeast: northeast);
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
        CameraUpdate.newLatLngBounds(bounds, 20),
      );
    }

    setState(() {});
  }
}
