import 'dart:async';
import 'dart:developer';

import 'package:device_admin_manager/device_manager.dart';
import 'package:flutter/material.dart';
import 'package:secure_wave/features/actions/models/action_model.dart';
import 'package:secure_wave/routes/app_routes.dart';

DeviceAdminManager get dpc => DeviceAdminManager.instance;

/// Shows a simple dialog with OK button
Future<void> _showMessageDialog(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("OK"),
        ),
      ],
    ),
  );
}

/// Shows a confirmation dialog with multiple actions
Future<bool?> _showConfirmationDialog(
  BuildContext context, {
  required String title,
  required String message,
  required List<Widget> actions,
}) async {
  return showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: actions,
    ),
  );
}

/// Standard actions for enable/disable dialogs
List<Widget> _getEnableDisableActions(
  BuildContext context,
  Future<void> Function({required bool disabled}) action,
) {
  return [
    TextButton(
      child: const Text('Cancel'),
      onPressed: () => Navigator.pop(context),
    ),
    TextButton(
      child: const Text('Disable'),
      onPressed: () {
        action(disabled: true);
        Navigator.pop(context);
      },
    ),
    TextButton(
      child: const Text('Enable'),
      onPressed: () {
        action(disabled: false);
        Navigator.pop(context);
      },
    ),
  ];
}

const toggleScreenAwakeLabel = "Toggle Screen Awake ⚡";

/// Organized task actions by category
final policyActions = <PolicyAction>[
  // Admin Privileges Section
  PolicyAction(
    label: "Request Admin Privileges",
    task: (context) async {
      final isGranted = await dpc.requestAdminPrivilegesIfNeeded();
      await _showMessageDialog(
        context,
        title: "Admin Privileges Request",
        message: isGranted
            ? "Admin privileges granted."
            : "Admin privileges not granted.\nEither declined or not a Device Policy Controller (DPC).",
      );
    },
  ),
  PolicyAction(
    label: "Check Admin Status",
    task: (context) async {
      final isAdmin = await dpc.isAdminActive();
      await _showMessageDialog(
        context,
        title: "Admin Status",
        message: isAdmin ? "Admin privileges active" : "No admin privileges",
      );
    },
  ),

  // Device Control Section
  PolicyAction(
    label: "Lock App (Kiosk Mode)",
    task: (context) async {
      try {
        bool isLocked = await dpc.lockApp(home: false);
        if (isLocked) {
          context.router.push(const EmergencyRoute());
        }
      } catch (e) {
        log('Error locking app: $e');
        await _showMessageDialog(context, title: "Error", message: "Failed to lock app");
      }
    },
  ),

  PolicyAction(
    label: "Unlocks App",
    task: (context) async {
      await dpc.unlockApp();
    },
  ),
  PolicyAction(
    label: "Set As Launcher",
    task: (context) async {
      await _showConfirmationDialog(
        context,
        title: 'Set As Launcher',
        message: 'Do you want to set the current app as the device\'s launcher.',
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Disable'),
            onPressed: () {
              dpc.setAsLauncher(enable: false);
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: const Text('Enable'),
            onPressed: () {
              dpc.setAsLauncher(enable: true);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  ),
  PolicyAction(
    label: "Clear Device Owner App",
    task: (_) => dpc.clearDeviceOwnerApp(),
  ),
  PolicyAction(
    label: toggleScreenAwakeLabel,
    task: (context) async {
      try {
        await dpc.setKeepScreenAwake(!(await dpc.isScreenAwake()));
      } catch (e) {
        log('Error toggling screen: $e');
        await _showMessageDialog(context, title: "Error", message: "Failed to toggle screen state");
      }
    },
  ),

  // Device Settings Section
  PolicyAction(
    label: "Device Information",
    task: (context) async {
      final info = await dpc.getDeviceInfo();
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Device Information"),
          content: info != null
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: info.entries.map((i) => Text("${i.key}: ${i.value}")).toList(),
                  ),
                )
              : const Text("Unable to retrieve device information."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    },
  ),
  PolicyAction(
    label: "REMOVE ADMIN",
    task: (context) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Confirm Wipe Data'),
            content: const Text(
              'Are you sure you want to wipe all device data?\n'
              'This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    await dpc.clearDeviceOwnerApp();
                  } catch (e) {
                    print('Error disabling device admin: $e');
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'remove',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          );
        },
      );
    },
  ),

  // Security Settings Section
  PolicyAction(
    label: "Set Camera Access",
    task: (context) async {
      await _showConfirmationDialog(
        context,
        title: 'Camera Access',
        message: 'Do you want to disable the camera?',
        actions: _getEnableDisableActions(context, dpc.setCameraDisabled),
      );
    },
  ),
  PolicyAction(
    label: "Screen Capture Settings",
    task: (context) async {
      await _showConfirmationDialog(
        context,
        title: 'Screen Capture',
        message: 'Do you want to disable screen capture?',
        actions: _getEnableDisableActions(context, dpc.setScreenCaptureDisabled),
      );
    },
  ),

  // Dangerous Operations Section
  PolicyAction(
    label: "Wipe Device Data",
    task: (context) async {
      final confirm = await _showConfirmationDialog(
        context,
        title: 'Confirm Device Wipe',
        message: 'Are you sure you want to wipe all device data?\nThis action cannot be undone.',
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text(
              'Wipe',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );

      if (confirm == true) {
        try {
          await dpc.wipeData();
        } catch (e) {
          log('Error wiping data: $e');
          await _showMessageDialog(context, title: "Error", message: "Failed to wipe device");
        }
      }
    },
  ),
];
