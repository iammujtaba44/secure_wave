abstract class ILocationService {
  Future<bool> requestLocationPermission();
  Future<Map<String, dynamic>> getCurrentLocationWithAddress();
}
