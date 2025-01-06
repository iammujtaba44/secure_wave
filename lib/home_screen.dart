import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<MyHomeScreen> {
  static const platform = MethodChannel('dpc_app_channel');
  final String deviceId = 'device_123';

  @override
  void initState() {
    super.initState();
    // listenToDeviceCommands();
  }

  void listenToDeviceCommands() {
    FirebaseFirestore.instance
        .collection('device_commands')
        .doc(deviceId)
        .snapshots()
        .listen((snapshot) {
      if (snapshot.exists) {
        bool shouldLock = snapshot.get('lock') ?? false;
        String message = snapshot.get('message') ?? 'Emergency Contact: 123-456-7890';

        if (shouldLock) {
          // Lock the device and show the emergency screen
          platform.invokeMethod('showLockScreen', {'message': message});
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DPC App")),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              platform.invokeMethod('showLockScreen', {'message': 'Hello DPC'});
            },
            child: const Text("Listening for Firebase commands..."),
          ),
        ],
      ),
    );
  }
}
