// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:pathly/models/full_routes_data_model/route.dart';
// import 'package:pathly/utils/calculate_distance.dart';
// import 'package:pathly/utils/format_distance.dart';
// import 'package:pathly/utils/format_time.dart';
// import 'package:pathly/utils/get_projection_on_segment.dart';
// import 'package:pathly/utils/location_service.dart';
// import 'package:pathly/utils/textstyles.dart';
// import 'package:pathly/widgets/custom_instruction_card.dart';
// import 'package:pathly/widgets/custom_then_card.dart';
// import 'package:pathly/widgets/rqi_widget.dart';
// import 'package:intl/intl.dart';

// class StartTripView extends StatefulWidget {
//   const StartTripView({    required this.originLocation,
//     required this.destinationLocation,
//     required this.fullRoutePoints,
//     required this.allPolylines,
//     required this.selectedRoute,super.key});
//   final LatLng originLocation;
//   final LatLng destinationLocation;
//   final List<LatLng> fullRoutePoints;
//   final List<Polyline> allPolylines;
//   final RouteModel selectedRoute;
  
//   @override
//   State<StartTripView> createState() => _StartTripViewState();
// }

// class _StartTripViewState extends State<StartTripView> {
//   late GoogleMapController googleMapController;
//   double currentZoomLevel = 11;
//   bool isZoomIn = false;
//   BitmapDescriptor? originMarkerIcon;
//   BitmapDescriptor? destinationMarkerIcon;
//   String mapStyle = '';
//   Set<Marker> markers = {};
//   Set<Polyline> polylines = {};
//   late String formattedTime;
//   late LatLng originLocation;
//   late LocationService locationService;
//   late final LatLng distinationLocation;
//   late final List<LatLng> fullRoutePoints;
//   late final List<Polyline> allPolylines;
//   late final RouteModel selectedRoute;
//   Set<Polyline> warningPolylines = {};
//   Polyline? mainRoutePolyline;
//   bool isArrived = false;
//   bool showDialog = true;

//   @override
//   void initState() {
//     super.initState();
//     locationService = LocationService();
//     originLocation = widget.originLocation;
//     distinationLocation = widget.destinationLocation;
//     fullRoutePoints = widget.fullRoutePoints;
//     allPolylines = widget.allPolylines;
//     selectedRoute = widget.selectedRoute;

//     for (var poly in allPolylines) {
//       if (poly.polylineId.value == "route") {
//         mainRoutePolyline = poly; 
//       } else {
//         warningPolylines.add(poly); 
//       }
//     }

//     final currentTime = DateTime.now();
//     formattedTime = DateFormat('h:mm a').format(currentTime).toLowerCase();

//     loadCustomMarker();
//     initMapStyle();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             style: mapStyle,
//             markers: markers,
//             polylines: polylines,
//             zoomControlsEnabled: false,
//          onMapCreated: (controller) async {
//   googleMapController = controller;

//   polylines.clear();

  
//   for (var poly in allPolylines) {
//     polylines.add(poly);
//   }

//   initMarkers();
//   setMyLocation();

//   setState(() {}); 
// },

//             initialCameraPosition: CameraPosition(
//               target:  widget.originLocation,
//               zoom: 15,
//             ),
//           ),

//                CustomThenCard(),
     
//       CustomInstructionCard(instruction:"instruction" ,instructionImage: 'assets/icons/left_direction.png',),
//           Positioned(
//             bottom: 0,
//             child: showDialog
//                 ? Container(
//                     alignment: Alignment.centerLeft,
//                     height: 90,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: Color(0xff1E1E1E),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(25),
//                         topRight: Radius.circular(25),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           height: 55,
//                           width: 55,
//                           margin: EdgeInsets.only(left: 32, right: 50),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             border: Border.all(color: Colors.white),
//                           ),
//                           child: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 showDialog = false;
//                               });
//                             },
//                             icon: Icon(Icons.close,
//                                 color: Colors.white, size: 30),
//                           ),
//                         ),
//                         Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               formatDuration(selectedRoute.duration),
//                               style: GoogleFonts.poppins(
//                                 color: Color(0xff019C4C),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 28,
//                               ),
//                             ),
//                             Text(
//                               "${formatDistance(selectedRoute.distanceMeters)}  $formattedTime",
//                               style: Styles.stylegrey16,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 : SizedBox(),
//           ),

//           Padding(
//             padding: const EdgeInsets.only(left: 12.0),
//             child: RqiWidget(alignment: Alignment.centerLeft),
//           ),
//         ],
//       ),
//     );
//   }

//   void initMapStyle() async {
//     String style = await DefaultAssetBundle.of(context)
//         .loadString("assets/map_styles/map_style.json");
//     setState(() {
//       mapStyle = style;
//     });
//   }

//   void toggleZoomLevel() {
//     double zoomIn = 16;
//     double zoomOut = 15;

//     isZoomIn ? currentZoomLevel = zoomOut : currentZoomLevel = zoomIn;

//     googleMapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: originLocation,
//           zoom: currentZoomLevel,
//         ),
//       ),
//     );

//     setState(() {
//       isZoomIn = !isZoomIn;
//     });
//   }

//   void loadCustomMarker() async {
//     originMarkerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(50, 50)),
//       'assets/icons/origin_marker.png',
//     );

//     destinationMarkerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(50, 50)),
//       'assets/icons/distination_Marker.png',
//     );

//     setState(() {});
//   }

//   void setMyLocation() async {
//   locationService.getRealTimeLocatin(
//     onData: (locationData) {
//       setMyLocationMarker(locationData);
//     },
//   );
// }


//   void setNewCameraPosition(LocationData locationData) {
//     CameraPosition cameraPosition = CameraPosition(
//       target: LatLng(locationData.latitude!, locationData.longitude!),
//       zoom: 15,
//     );
//     googleMapController.animateCamera(
//       CameraUpdate.newCameraPosition(cameraPosition),
//     );
//   }

//   void initMarkers() {
//     if (originMarkerIcon == null || destinationMarkerIcon == null) return;

//     Marker originMarker = Marker(
//       markerId: MarkerId("origin"),
//       position: originLocation,
//       icon: originMarkerIcon!,
//     );

//     Marker destinationMarker = Marker(
//       markerId: MarkerId("destination"),
//       position: distinationLocation,
//       icon: destinationMarkerIcon!,
//     );

//     markers.addAll([originMarker, destinationMarker]);

//     setState(() {});
//   }

  
//   void setMyLocationMarker(LocationData locationData) {
//   if (fullRoutePoints.isEmpty) return;

//   LatLng currentPos = LatLng(locationData.latitude!, locationData.longitude!);

//   if (!isArrived) {
//     double distanceToDestination = calculateDistance(
//       currentPos.latitude,
//       currentPos.longitude,
//       distinationLocation.latitude,
//       distinationLocation.longitude,
//     );
//     if (distanceToDestination < 0.01) {
//       markers.removeWhere((m) => m.markerId == MarkerId("origin"));
//       polylines.clear();
//       isArrived = true;
//       setState(() {});
//       return;
//     }
//   }

//   if (isArrived) return;

//   markers.removeWhere((m) => m.markerId == MarkerId("origin"));
//   markers.add(Marker(
//     markerId: MarkerId("origin"),
//     position: currentPos,
//     icon: originMarkerIcon!,
//   ));

//   markers.removeWhere((m) => m.markerId == MarkerId("destination"));
//   markers.add(Marker(
//     markerId: MarkerId("destination"),
//     position: distinationLocation,
//     icon: destinationMarkerIcon!,
//   ));

//   double minDistance = double.infinity;
//   LatLng bestProjection = fullRoutePoints[0];
//   int bestSegmentIndex = 0;

//   for (int i = 0; i < fullRoutePoints.length - 1; i++) {
//     LatLng a = fullRoutePoints[i];
//     LatLng b = fullRoutePoints[i + 1];
//     LatLng projection = getProjectionOnSegment(currentPos, a, b);

//     double distance = calculateDistance(
//       currentPos.latitude, currentPos.longitude,
//       projection.latitude, projection.longitude);

//     if (distance < minDistance) {
//       minDistance = distance;
//       bestProjection = projection;
//       bestSegmentIndex = i;
//     }
//   }

//   polylines.clear();

//   if (mainRoutePolyline != null) {
//     polylines.add(Polyline(
//       polylineId: mainRoutePolyline!.polylineId,
//       points: [bestProjection, ...fullRoutePoints.sublist(bestSegmentIndex + 1)],
//       color: mainRoutePolyline!.color,
//       width: mainRoutePolyline!.width,
//     ));
//   }


//   for (var warning in warningPolylines) {
//     if (warning.points.length < 2) continue;

//     LatLng a = warning.points.first;
//     LatLng b = warning.points.last;

//     LatLng projection = getProjectionOnSegment(currentPos, a, b);

//     double segLength = calculateDistance(a.latitude, a.longitude, b.latitude, b.longitude);
//     double distToProj = calculateDistance(a.latitude, a.longitude, projection.latitude, projection.longitude);
//     double distToEnd = calculateDistance(b.latitude, b.longitude, projection.latitude, projection.longitude);

//     bool isInsideSegment = (distToProj + distToEnd - segLength).abs() < 0.001;

//     if (isInsideSegment && distToEnd > 0.005) {
//       polylines.add(Polyline(
//         polylineId: warning.polylineId,
//         points: [projection, b],
//         color: warning.color,
//         width: warning.width,
//       ));
//     }
//   }

//   setState(() {});
// }

// }





// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:pathly/models/full_routes_data_model/route.dart';
// import 'package:pathly/models/full_routes_data_model/step.dart';
// import 'package:pathly/utils/calculate_distance.dart';
// import 'package:pathly/utils/format_distance.dart';
// import 'package:pathly/utils/format_time.dart';
// import 'package:pathly/utils/get_projection_on_segment.dart';
// import 'package:pathly/utils/location_service.dart';
// import 'package:pathly/utils/textstyles.dart';
// import 'package:pathly/widgets/custom_instruction_card.dart';
// import 'package:pathly/widgets/custom_then_card.dart';
// import 'package:pathly/widgets/rqi_widget.dart';
// import 'package:intl/intl.dart';

// class StartTripView extends StatefulWidget {
//   const StartTripView({    required this.originLocation,
//     required this.destinationLocation,
//     required this.fullRoutePoints,
//     required this.allPolylines,
//     required this.selectedRoute,super.key});
//   final LatLng originLocation;
//   final LatLng destinationLocation;
//   final List<LatLng> fullRoutePoints;
//   final List<Polyline> allPolylines;
//   final RouteModel selectedRoute;
  
//   @override
//   State<StartTripView> createState() => _StartTripViewState();
// }

// class _StartTripViewState extends State<StartTripView> {
//   late GoogleMapController googleMapController;
//   double currentZoomLevel = 11;
//   bool isZoomIn = false;
//   BitmapDescriptor? originMarkerIcon;
//   BitmapDescriptor? destinationMarkerIcon;
//   String mapStyle = '';
//   Set<Marker> markers = {};
//   Set<Polyline> polylines = {};
//   late String formattedTime;
//   late LatLng originLocation;
//   late LocationService locationService;
//   late final LatLng distinationLocation;
//   late final List<LatLng> fullRoutePoints;
//   late final List<Polyline> allPolylines;
//   late final RouteModel selectedRoute;
//   Set<Polyline> warningPolylines = {};
//   Polyline? mainRoutePolyline;
//   bool isArrived = false;
//   bool showDialog = true;
//   late final List<StepModel> allSteps;
// int currentStepIndex = 0;
// double distanceCovered = 0.0;

// String currentInstructionText = "";
// String currentInstructionImage = "assets/icons/head_direction.png";


//   @override
//   void initState() {
//     super.initState();
//     locationService = LocationService();
//     originLocation = widget.originLocation;
//     distinationLocation = widget.destinationLocation;
//     fullRoutePoints = widget.fullRoutePoints;
//     allPolylines = widget.allPolylines;
//     selectedRoute = widget.selectedRoute;

//     for (var poly in allPolylines) {
//       if (poly.polylineId.value == "route") {
//         mainRoutePolyline = poly; 
//       } else {
//         warningPolylines.add(poly); 
//       }
//     }

//     final currentTime = DateTime.now();
//     formattedTime = DateFormat('h:mm a').format(currentTime).toLowerCase();

//     loadCustomMarker();
//     initMapStyle();
//     allSteps = widget.selectedRoute.legs!
//       .expand((leg) => leg.steps!)
//       .toList();
//       if (allSteps.isNotEmpty) {
//   final firstStep = allSteps.first;

//   currentInstructionText = firstStep.navigationInstruction?.instructions ?? '';

//   final maneuver = firstStep.navigationInstruction?.maneuver?.toUpperCase() ?? '';
//   if (maneuver.contains('LEFT')) {
//     currentInstructionImage = 'assets/icons/left_direction.png';
//   } else if (maneuver.contains('RIGHT')) {
//     currentInstructionImage = 'assets/icons/right_direction.png';
//   } else {
//     currentInstructionImage = 'assets/icons/head_direction.png';
//   }
// }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           GoogleMap(
//             style: mapStyle,
//             markers: markers,
//             polylines: polylines,
//             zoomControlsEnabled: false,
//          onMapCreated: (controller) async {
//   googleMapController = controller;

//   polylines.clear();

  
//   for (var poly in allPolylines) {
//     polylines.add(poly);
//   }

//   initMarkers();
//   setMyLocation();

//   setState(() {}); 
// },

//             initialCameraPosition: CameraPosition(
//               target:  widget.originLocation,
//               zoom: 15,
//             ),
//           ),

//                CustomThenCard(),
//                currentStepIndex < allSteps.length
//   ? CustomInstructionCard(
//     instruction: currentInstructionText,
//     instructionImage: currentInstructionImage,
    
//     //stepNumber: '${currentStepIndex + 1}/${allSteps.length}',
//   )
//   : SizedBox(),
 
     
//           Positioned(
//             bottom: 0,
//             child: showDialog
//                 ? Container(
//                     alignment: Alignment.centerLeft,
//                     height: 90,
//                     width: MediaQuery.of(context).size.width,
//                     decoration: BoxDecoration(
//                       color: Color(0xff1E1E1E),
//                       borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(25),
//                         topRight: Radius.circular(25),
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           height: 55,
//                           width: 55,
//                           margin: EdgeInsets.only(left: 32, right: 50),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             border: Border.all(color: Colors.white),
//                           ),
//                           child: IconButton(
//                             onPressed: () {
//                               setState(() {
//                                 showDialog = false;
//                               });
//                             },
//                             icon: Icon(Icons.close,
//                                 color: Colors.white, size: 30),
//                           ),
//                         ),
//                         Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Text(
//                               formatDuration(selectedRoute.duration),
//                               style: GoogleFonts.poppins(
//                                 color: Color(0xff019C4C),
//                                 fontWeight: FontWeight.w500,
//                                 fontSize: 28,
//                               ),
//                             ),
//                             Text(
//                               "${formatDistance(selectedRoute.distanceMeters)}  $formattedTime",
//                               style: Styles.stylegrey16,
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   )
//                 : SizedBox(),
//           ),

//           Padding(
//             padding: const EdgeInsets.only(left: 12.0),
//             child: RqiWidget(alignment: Alignment.centerLeft),
//           ),
//         ],
//       ),
//     );
//   }

//   void initMapStyle() async {
//     String style = await DefaultAssetBundle.of(context)
//         .loadString("assets/map_styles/map_style.json");
//     setState(() {
//       mapStyle = style;
//     });
//   }

//   void toggleZoomLevel() {
//     double zoomIn = 16;
//     double zoomOut = 15;

//     isZoomIn ? currentZoomLevel = zoomOut : currentZoomLevel = zoomIn;

//     googleMapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         CameraPosition(
//           target: originLocation,
//           zoom: currentZoomLevel,
//         ),
//       ),
//     );

//     setState(() {
//       isZoomIn = !isZoomIn;
//     });
//   }

//   void loadCustomMarker() async {
//     originMarkerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(50, 50)),
//       'assets/icons/origin_marker.png',
//     );

//     destinationMarkerIcon = await BitmapDescriptor.fromAssetImage(
//       const ImageConfiguration(size: Size(50, 50)),
//       'assets/icons/distination_Marker.png',
//     );

//     setState(() {});
//   }

//   void setMyLocation() async {
//   locationService.getRealTimeLocatin(
//     onData: (locationData) {
//       setMyLocationMarker(locationData);
//     },
//   );
// }


//   void setNewCameraPosition(LocationData locationData) {
//     CameraPosition cameraPosition = CameraPosition(
//       target: LatLng(locationData.latitude!, locationData.longitude!),
//       zoom: 15,
//     );
//     googleMapController.animateCamera(
//       CameraUpdate.newCameraPosition(cameraPosition),
//     );
//   }

//   void initMarkers() {
//     if (originMarkerIcon == null || destinationMarkerIcon == null) return;

//     Marker originMarker = Marker(
//       markerId: MarkerId("origin"),
//       position: originLocation,
//       icon: originMarkerIcon!,
//     );

//     Marker destinationMarker = Marker(
//       markerId: MarkerId("destination"),
//       position: distinationLocation,
//       icon: destinationMarkerIcon!,
//     );

//     markers.addAll([originMarker, destinationMarker]);

//     setState(() {});
//   }

//   String getRemainingDistanceForCurrentStep() {
//   if (currentStepIndex >= allSteps.length) return '';
  
//   double totalDistance = allSteps[currentStepIndex].distanceMeters?.toDouble() ?? 0;
//   double remaining = totalDistance - distanceCovered;
  
//   return formatDistance(remaining.toInt());
// }
// void setMyLocationMarker(LocationData locationData) {
//   if (fullRoutePoints.isEmpty) return;

//   LatLng currentPos = LatLng(locationData.latitude!, locationData.longitude!);

//   // Check if arrived at destination
//   if (!isArrived) {
//     double distanceToDestination = calculateDistance(
//       currentPos.latitude,
//       currentPos.longitude,
//       distinationLocation.latitude,
//       distinationLocation.longitude,
//     );
//     if (distanceToDestination < 20) { // 20 meters threshold
//       markers.removeWhere((m) => m.markerId == MarkerId("origin"));
//       polylines.clear();
//       isArrived = true;
//       setState(() {});
//       return;
//     }
//   }

//   if (isArrived) return;

//   // Update markers
//   markers.removeWhere((m) => m.markerId == MarkerId("origin"));
//   markers.add(Marker(
//     markerId: MarkerId("origin"),
//     position: currentPos,
//     icon: originMarkerIcon!,
//   ));

//   // Update polylines
//   updatePolylines(currentPos);

//   // Update current step and instructions
//   updateCurrentStep(currentPos);

//   setState(() {});
// }
// void updatePolylines(LatLng currentPos) {
//   double minDistance = double.infinity;
//   LatLng bestProjection = fullRoutePoints[0];
//   int bestSegmentIndex = 0;

//   for (int i = 0; i < fullRoutePoints.length - 1; i++) {
//     LatLng a = fullRoutePoints[i];
//     LatLng b = fullRoutePoints[i + 1];
//     LatLng projection = getProjectionOnSegment(currentPos, a, b);

//     double distance = calculateDistance(
//       currentPos.latitude, currentPos.longitude,
//       projection.latitude, projection.longitude);

//     if (distance < minDistance) {
//       minDistance = distance;
//       bestProjection = projection;
//       bestSegmentIndex = i;
//     }
//   }

//   // clear and re-add main route
//   polylines.clear();

//   if (mainRoutePolyline != null) {
//     polylines.add(Polyline(
//       polylineId: mainRoutePolyline!.polylineId,
//       points: [bestProjection, ...fullRoutePoints.sublist(bestSegmentIndex + 1)],
//       color: mainRoutePolyline!.color,
//       width: mainRoutePolyline!.width,
//     ));
//   }

//   for (var warning in warningPolylines) {
//     polylines.add(warning);
//   }
// }


// // void updatePolylines(LatLng currentPos) {
// //   double minDistance = double.infinity;
// //   LatLng bestProjection = fullRoutePoints[0];
// //   int bestSegmentIndex = 0;

// //   for (int i = 0; i < fullRoutePoints.length - 1; i++) {
// //     LatLng a = fullRoutePoints[i];
// //     LatLng b = fullRoutePoints[i + 1];
// //     LatLng projection = getProjectionOnSegment(currentPos, a, b);

// //     double distance = calculateDistance(
// //       currentPos.latitude, currentPos.longitude,
// //       projection.latitude, projection.longitude);

// //     if (distance < minDistance) {
// //       minDistance = distance;
// //       bestProjection = projection;
// //       bestSegmentIndex = i;
// //     }
// //   }

// //   polylines.clear();

// //   if (mainRoutePolyline != null) {
// //     polylines.add(Polyline(
// //       polylineId: mainRoutePolyline!.polylineId,
// //       points: [bestProjection, ...fullRoutePoints.sublist(bestSegmentIndex + 1)],
// //       color: mainRoutePolyline!.color,
// //       width: mainRoutePolyline!.width,
// //     ));
// //   }
// // }

// void updateCurrentStep(LatLng currentPos) {
//   if (currentStepIndex >= allSteps.length) return;

//   // Find the closest point on the route
//   int closestPointIndex = 0;
//   double minDistance = double.infinity;
  
//   for (int i = 0; i < fullRoutePoints.length; i++) {
//     double distance = calculateDistance(
//       currentPos.latitude, currentPos.longitude,
//       fullRoutePoints[i].latitude, fullRoutePoints[i].longitude);
    
//     if (distance < minDistance) {
//       minDistance = distance;
//       closestPointIndex = i;
//     }
//   }

//   // Calculate cumulative distance up to the closest point
//   double cumulativeDistance = 0;
//   for (int i = 0; i < closestPointIndex; i++) {
//     cumulativeDistance += calculateDistance(
//       fullRoutePoints[i].latitude, fullRoutePoints[i].longitude,
//       fullRoutePoints[i+1].latitude, fullRoutePoints[i+1].longitude);
//   }

//   // Find which step this distance corresponds to
//   double stepStartDistance = 0;
//   for (int i = 0; i < allSteps.length; i++) {
//     double stepEndDistance = stepStartDistance + (allSteps[i].distanceMeters ?? 0);
    
//     if (cumulativeDistance >= stepStartDistance && cumulativeDistance < stepEndDistance) {
//       if (i != currentStepIndex) {
//         currentStepIndex = i;
//         updateCurrentInstruction();
//       }
//       break;
//     }
//     stepStartDistance = stepEndDistance;
//   }
// }void updateCurrentInstruction() {
//   if (currentStepIndex >= allSteps.length) return;
  
//   final step = allSteps[currentStepIndex];
//   currentInstructionText = step.navigationInstruction?.instructions ?? '';

//   final maneuver = step.navigationInstruction?.maneuver?.toUpperCase() ?? '';
//   if (maneuver.contains('LEFT')) {
//     currentInstructionImage = 'assets/icons/left_direction.png';
//   } else if (maneuver.contains('RIGHT')) {
//     currentInstructionImage = 'assets/icons/right_direction.png';
//   } else if (maneuver.contains('UTURN')) {
//     currentInstructionImage = 'assets/icons/uturn_direction.png';
//   } else {
//     currentInstructionImage = 'assets/icons/head_direction.png';
//   }
  
//   setState(() {});
// }


// }






import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:pathly/models/full_routes_data_model/route.dart';
import 'package:pathly/models/full_routes_data_model/step.dart';
import 'package:pathly/utils/calculate_distance.dart';
import 'package:pathly/utils/format_distance.dart';
import 'package:pathly/utils/format_time.dart';
import 'package:pathly/utils/get_projection_on_segment.dart';
import 'package:pathly/utils/location_service.dart';
import 'package:pathly/utils/textstyles.dart';
import 'package:pathly/widgets/custom_instruction_card.dart';
import 'package:pathly/widgets/custom_then_card.dart';
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
  late final List<StepModel> allSteps;
int currentStepIndex = 0;
double distanceCovered = 0.0;

String currentInstructionText = "";
String currentInstructionImage = "assets/icons/head_direction.png";


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
    allSteps = widget.selectedRoute.legs!
      .expand((leg) => leg.steps!)
      .toList();
      if (allSteps.isNotEmpty) {
  final firstStep = allSteps.first;

  currentInstructionText = firstStep.navigationInstruction?.instructions ?? '';

  final maneuver = firstStep.navigationInstruction?.maneuver?.toUpperCase() ?? '';
  if (maneuver.contains('LEFT')) {
    currentInstructionImage = 'assets/icons/left_direction.png';
  } else if (maneuver.contains('RIGHT')) {
    currentInstructionImage = 'assets/icons/right_direction.png';
  } else {
    currentInstructionImage = 'assets/icons/head_direction.png';
  }
}

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

               CustomThenCard(),
               currentStepIndex < allSteps.length
  ? CustomInstructionCard(
    instruction: currentInstructionText,
    instructionImage: currentInstructionImage,
    
    //stepNumber: '${currentStepIndex + 1}/${allSteps.length}',
  )
  : SizedBox(),
 
     
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

  String getRemainingDistanceForCurrentStep() {
  if (currentStepIndex >= allSteps.length) return '';
  
  double totalDistance = allSteps[currentStepIndex].distanceMeters?.toDouble() ?? 0;
  double remaining = totalDistance - distanceCovered;
  
  return formatDistance(remaining.toInt());
}
void setMyLocationMarker(LocationData locationData) {
  if (fullRoutePoints.isEmpty) return;

  LatLng currentPos = LatLng(locationData.latitude!, locationData.longitude!);

  // Check if arrived at destination
  if (!isArrived) {
    double distanceToDestination = calculateDistance(
      currentPos.latitude,
      currentPos.longitude,
      distinationLocation.latitude,
      distinationLocation.longitude,
    );
    if (distanceToDestination < 20) { // 20 meters threshold
      markers.removeWhere((m) => m.markerId == MarkerId("origin"));
      polylines.clear();
      isArrived = true;
      setState(() {});
      return;
    }
  }

  if (isArrived) return;

  // Update markers
  markers.removeWhere((m) => m.markerId == MarkerId("origin"));
  markers.add(Marker(
    markerId: MarkerId("origin"),
    position: currentPos,
    icon: originMarkerIcon!,
  ));

  // Update polylines
  updatePolylines(currentPos);

  // Update current step and instructions
  updateCurrentStep(currentPos);

  setState(() {});
}
void updatePolylines(LatLng currentPos) {
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

  // clear and re-add main route
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
    polylines.add(warning);
  }
}


// void updatePolylines(LatLng currentPos) {
//   double minDistance = double.infinity;
//   LatLng bestProjection = fullRoutePoints[0];
//   int bestSegmentIndex = 0;

//   for (int i = 0; i < fullRoutePoints.length - 1; i++) {
//     LatLng a = fullRoutePoints[i];
//     LatLng b = fullRoutePoints[i + 1];
//     LatLng projection = getProjectionOnSegment(currentPos, a, b);

//     double distance = calculateDistance(
//       currentPos.latitude, currentPos.longitude,
//       projection.latitude, projection.longitude);

//     if (distance < minDistance) {
//       minDistance = distance;
//       bestProjection = projection;
//       bestSegmentIndex = i;
//     }
//   }

//   polylines.clear();

//   if (mainRoutePolyline != null) {
//     polylines.add(Polyline(
//       polylineId: mainRoutePolyline!.polylineId,
//       points: [bestProjection, ...fullRoutePoints.sublist(bestSegmentIndex + 1)],
//       color: mainRoutePolyline!.color,
//       width: mainRoutePolyline!.width,
//     ));
//   }
// }

void updateCurrentStep(LatLng currentPos) {
  if (currentStepIndex >= allSteps.length) return;

  // Find the closest point on the route
  int closestPointIndex = 0;
  double minDistance = double.infinity;
  
  for (int i = 0; i < fullRoutePoints.length; i++) {
    double distance = calculateDistance(
      currentPos.latitude, currentPos.longitude,
      fullRoutePoints[i].latitude, fullRoutePoints[i].longitude);
    
    if (distance < minDistance) {
      minDistance = distance;
      closestPointIndex = i;
    }
  }

  // Calculate cumulative distance up to the closest point
  double cumulativeDistance = 0;
  for (int i = 0; i < closestPointIndex; i++) {
    cumulativeDistance += calculateDistance(
      fullRoutePoints[i].latitude, fullRoutePoints[i].longitude,
      fullRoutePoints[i+1].latitude, fullRoutePoints[i+1].longitude);
  }

  // Find which step this distance corresponds to
  double stepStartDistance = 0;
  for (int i = 0; i < allSteps.length; i++) {
    double stepEndDistance = stepStartDistance + (allSteps[i].distanceMeters ?? 0);
    
    if (cumulativeDistance >= stepStartDistance && cumulativeDistance < stepEndDistance) {
      if (i != currentStepIndex) {
        currentStepIndex = i;
        updateCurrentInstruction();
      }
      break;
    }
    stepStartDistance = stepEndDistance;
  }
}void updateCurrentInstruction() {
  if (currentStepIndex >= allSteps.length) return;
  
  final step = allSteps[currentStepIndex];
  currentInstructionText = step.navigationInstruction?.instructions ?? '';

  final maneuver = step.navigationInstruction?.maneuver?.toUpperCase() ?? '';
  if (maneuver.contains('LEFT')) {
    currentInstructionImage = 'assets/icons/left_direction.png';
  } else if (maneuver.contains('RIGHT')) {
    currentInstructionImage = 'assets/icons/right_direction.png';
  } else if (maneuver.contains('UTURN')) {
    currentInstructionImage = 'assets/icons/uturn_direction.png';
  } else {
    currentInstructionImage = 'assets/icons/head_direction.png';
  }
  
  setState(() {});
}


}

