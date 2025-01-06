import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late DatabaseReference _dbRef;

  // Singleton pattern
  static final RealtimeDatabaseService _instance = RealtimeDatabaseService._internal();

  factory RealtimeDatabaseService() {
    return _instance;
  }

  RealtimeDatabaseService._internal() {
    _dbRef = _database.ref();
  }

  Stream<DatabaseEvent> listenToPath(String path) {
    return _dbRef.child(path).onValue;
  }

  Stream<DatabaseEvent> listenToUserData(String userId) {
    return _dbRef.child('users/$userId').onValue;
  }

  // Example method to listen to specific device data
  Stream<DatabaseEvent> listenToDeviceData(String deviceId) {
    return _dbRef.child('devices/$deviceId').onValue;
  }

  // Method to update data
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    try {
      await _dbRef.child(path).update(data);
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  // Method to set data
  Future<void> setData(String path, Map<String, dynamic> data) async {
    try {
      await _dbRef.child(path).set(data);
    } catch (e) {
      throw Exception('Failed to set data: $e');
    }
  }

  // Method to remove data
  Future<void> removeData(String path) async {
    try {
      await _dbRef.child(path).remove();
    } catch (e) {
      throw Exception('Failed to remove data: $e');
    }
  }
}
