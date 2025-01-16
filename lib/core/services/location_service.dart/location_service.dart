import 'dart:developer';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import './i_location_service.dart';

class LocationService implements ILocationService {
  @override
  Future<bool> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        log('Location permission denied');
        return false;
      }
    }
    return true;
  }

  @override
  Future<Map<String, dynamic>> getCurrentLocationWithAddress() async {
    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );

    final List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    final Placemark place = placemarks.first;
    final String address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';

    return {
      'latitude': position.latitude,
      'longitude': position.longitude,
      'address': address,
      'timestamp': DateTime.now().toString(),
    };
  }
}
