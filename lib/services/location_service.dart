import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<LocationData?> getLocation() async {
    return await _location.getLocation();
  }
}
