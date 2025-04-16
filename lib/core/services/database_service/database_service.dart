import 'dart:async';
import 'dart:developer';

import 'package:firebase_database/firebase_database.dart';
import 'package:secure_wave/core/providers/app_status_provider/app_status_enum.dart';
import 'package:secure_wave/core/services/database_service/i_database_service.dart';

class DatabaseService implements IDatabaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  late DatabaseReference _dbRef;
  final Map<String, StreamSubscription<DatabaseEvent>> _activeSubscriptions = {};

  DatabaseService() {
    _dbRef = _database.ref();
    _database.setPersistenceEnabled(true); // Enable offline persistence
    _dbRef.keepSynced(true);
  }

  // Method to start listening with background capability
  @override
  Future<StreamSubscription<DatabaseEvent>> listenWithBackground(
    String path,
    Function(DatabaseEvent event) onData,
  ) async {
    // Cancel existing subscription if any
    await _activeSubscriptions[path]?.cancel();

    // Create new subscription
    final subscription = _dbRef.child(path).onValue.listen(
      (event) {
        onData(event);
      },
      onError: (error) {
        print('Error listening to $path: $error');
      },
    );

    _activeSubscriptions[path] = subscription;
    return subscription;
  }

  // Method to stop specific listener
  @override
  Future<void> stopListening(String path) async {
    await _activeSubscriptions[path]?.cancel();
    _activeSubscriptions.remove(path);
  }

  // Method to stop all listeners
  @override
  Future<void> stopAllListeners() async {
    for (final subscription in _activeSubscriptions.values) {
      await subscription.cancel();
    }
    _activeSubscriptions.clear();
  }

  // Enhanced methods with background support
  @override
  Future<StreamSubscription<DatabaseEvent>> listenToUserDataWithBackground(
    String userId,
    Function(DatabaseEvent event) onData,
  ) {
    return listenWithBackground('users/$userId', onData);
  }

  @override
  Future<StreamSubscription<DatabaseEvent>> listenToDeviceDataWithBackground(
    String deviceId,
    Function(DatabaseEvent event) onData,
  ) {
    return listenWithBackground('devices/$deviceId', onData);
  }

  @override
  Stream<DatabaseEvent> listenToPath(String path) {
    return _dbRef.child(path).onValue;
  }

  @override
  Stream<DatabaseEvent> listenToUserData(String userId) {
    return _dbRef.child('users/$userId').onValue;
  }

  @override
  // Example method to listen to specific device data
  Stream<DatabaseEvent> listenToDeviceData(String deviceId) {
    return _dbRef.child('devices/$deviceId').onValue;
  }

  @override
  Future<void> updateData(String path, Map<String, dynamic> data) async {
    try {
      await _dbRef.child(path).update(data);
    } catch (e) {
      throw Exception('Failed to update data: $e');
    }
  }

  @override
  Future<void> setData(String path, Map<String, dynamic> data, {bool merge = false}) async {
    try {
      await _dbRef.child(path).set(data);
    } catch (e) {
      throw Exception('Failed to set data: $e');
    }
  }

  @override
  Future<Map<String, dynamic>> getData(String path) async {
    try {
      final data = await _dbRef.child(path).get();
      if (data.value == null) {
        return {};
      }
      return Map<String, dynamic>.from(data.value as Map);
    } catch (e) {
      throw Exception('Failed to get data: $e');
    }
  }

  @override
  Future<void> removeData(String path) async {
    try {
      await _dbRef.child(path).remove();
    } catch (e) {
      throw Exception('Failed to remove data: $e');
    }
  }

  Stream<Map<String, dynamic>> streamData(String path) {
    try {
      return _dbRef.child(path).onValue.map((event) {
        if (event.snapshot.value != null) {
          return Map<String, dynamic>.from(event.snapshot.value as Map);
        } else {
          return {'app_status': AppStatus.userNotFound.name};
        }
      }).handleError((error) {
        log('Stream error: $error');
        // Return a safe default state in case of error
        return {'app_status': AppStatus.idle.name};
      });
    } catch (e) {
      log('StreamData setup error: $e');
      // Return an empty stream with default state in case of setup error
      return Stream.value({'app_status': AppStatus.idle.name});
    }
  }

  // Add method to get notification settings
  Future<Map<String, dynamic>> getNotificationSettings() async {
    try {
      final snapshot = await _dbRef.child('support').get();
      if (snapshot.exists) {
        return Map<String, dynamic>.from(snapshot.value as Map);
      }
      return {
        'title': 'Secure Wave',
        'text': 'Service is running',
      };
    } catch (e) {
      log('Error fetching notification settings: $e');
      return {
        'title': 'Secure Wave',
        'text': 'Service is running',
      };
    }
  }
}
