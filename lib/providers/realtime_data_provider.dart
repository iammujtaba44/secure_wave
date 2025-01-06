import 'package:flutter/foundation.dart';
import 'package:firebase_database/firebase_database.dart';
import '../services/realtime_database_service.dart';

class RealtimeDataProvider extends ChangeNotifier {
  final RealtimeDatabaseService _dbService = RealtimeDatabaseService();
  Map<String, dynamic> _data = {};

  Map<String, dynamic> get data => _data;

  void startListening(String path) {
    _dbService.listenToPath(path).listen(
      (DatabaseEvent event) {
        if (event.snapshot.value != null) {
          // Convert the data to Map<String, dynamic>
          _data = Map<String, dynamic>.from(
            event.snapshot.value as Map,
          );
          notifyListeners();
        }
      },
      onError: (error) {
        debugPrint('Error: $error');
      },
    );
  }

  Future<void> updateData(String path, Map<String, dynamic> newData) async {
    try {
      await _dbService.updateData(path, newData);
    } catch (e) {
      debugPrint('Error updating data: $e');
      rethrow;
    }
  }
}
