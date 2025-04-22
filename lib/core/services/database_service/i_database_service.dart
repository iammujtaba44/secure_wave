import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

abstract class IDatabaseService {
  Future<StreamSubscription<DatabaseEvent>> listenWithBackground(
    String path,
    Function(DatabaseEvent event) onData,
  );

  Future<StreamSubscription<DatabaseEvent>> listenToUserDataWithBackground(
    String userId,
    Function(DatabaseEvent event) onData,
  );

  Future<StreamSubscription<DatabaseEvent>> listenToDeviceDataWithBackground(
    String deviceId,
    Function(DatabaseEvent event) onData,
  );

  Future<void> stopListening(String path);

  Future<void> stopAllListeners();
  Stream<DatabaseEvent> listenToPath(String path);

  Stream<DatabaseEvent> listenToUserData(String userId);

  Stream<DatabaseEvent> listenToDeviceData(String deviceId);

  Future<void> updateData(String path, Map<String, dynamic> data);

  Future<void> setData(String path, Map<String, dynamic> data, {bool merge = false});

  Future<Map<String, dynamic>> getData(String path);

  Future<void> removeData(String path);

  Stream<Map<String, dynamic>> streamData(String path);

  Future<void> setDataWithAutoId(String path, Map<String, dynamic> data);
}
