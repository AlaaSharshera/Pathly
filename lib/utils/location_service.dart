import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  Future<void> checkandRequestLocationService() async {
    var isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        throw LocationServiceException();
      }
    }
  }

  Future<void> checkandRequestLocationPermission() async {
    var permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.deniedForever) {
      throw LocationPermissionException();
    }
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        throw LocationPermissionException();
      }
    }
  }

  void getRealTimeLocatin({void Function(LocationData)? onData}) async {
    await checkandRequestLocationService();
    await checkandRequestLocationPermission();
    await location.changeSettings(distanceFilter: 3);
    location.onLocationChanged.listen(onData);
  }

  Future<LocationData> getLocation() async {
    await checkandRequestLocationService();
    await checkandRequestLocationPermission();
    return await location.getLocation();
  }
}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
