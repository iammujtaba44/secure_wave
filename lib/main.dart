// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'task_actions.dart';

// class ScreenAwakeStatusProvider extends ChangeNotifier {
//   bool _isScreenAwake = false;

//   bool get isScreenAwake => _isScreenAwake;

//   Future<void> updateScreenAwakeStatus({bool? value}) async {
//     _isScreenAwake = value ?? await dpc.isScreenAwake();
//     notifyListeners();
//   }
// }

// final _statusProvider = ScreenAwakeStatusProvider();

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   initKioskMode();
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => _statusProvider,
//       child: const MyApp(),
//     ),
//   );
// }

// const bootCompletedHandlerStartedKey = "bootCompletedHandlerStarted";
// Future<void> enableKioskMode() async {
//   try {
//     await dpc.setAsLauncher();
//     await dpc.lockApp();
//     await dpc.setKeepScreenAwake(true);
//     _statusProvider.updateScreenAwakeStatus(value: true);

//     await dpc.put(bootCompletedHandlerStartedKey, content: "false");
//   } catch (e) {
//     print('dpc:: enableKioskMode error: $e');
//   }
// }

// Future<void> initKioskMode() async {
//   dpc.handleBootCompleted((_) async {
//     final startedValue = await dpc.get(bootCompletedHandlerStartedKey);
//     final isStarted = startedValue == "true";
//     print('dpc:: handleBootCompleted:: isStarted: $isStarted');
//     await dpc.put(bootCompletedHandlerStartedKey, content: "true");

//     if (!isStarted) {
//       try {
//         await dpc.startApp();
//       } catch (e) {
//         print('dpc:: handleBootCompleted startApp error: $e');
//       }
//     }

//     // It's important to highlight that if handleBootCompleted was called
//     // earlier, dpc.startApp() could make Flutter engine reset (or invalidate)
//     // the code to its initial entry point "main".
//     // As a result, there's a high probability that the subsequent
//     // (next) code lines won't execute as expected.
//     // We will not call enableKioskMode method here.
//     // enableKioskMode();
//   });

//   final startedValue = await dpc.get(bootCompletedHandlerStartedKey);
//   final isStarted = startedValue == "true";
//   print('dpc:: init:: startedValue $startedValue, isStarted: $isStarted');

//   if (isStarted) {
//     enableKioskMode();
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: HomePage(),
//     );
//   }
// }

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   void initState() {
//     super.initState();
//     _statusProvider.updateScreenAwakeStatus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSizeWidth = MediaQuery.sizeOf(context).width;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Device Policy Controller Example'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               dpc.setKeepScreenAwake(!_statusProvider.isScreenAwake).then(
//                 (value) {
//                   _statusProvider.updateScreenAwakeStatus(value: !_statusProvider.isScreenAwake);
//                 },
//               );
//             },
//             child: Consumer<ScreenAwakeStatusProvider>(builder: (context, statusProvider, _) {
//               return Icon(
//                 Icons.flash_on,
//                 color: statusProvider.isScreenAwake ? Colors.amberAccent : Colors.blueGrey,
//                 size: 36,
//               );
//             }),
//           ),
//           const SizedBox(width: 12),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//               child: GridView.builder(
//                 padding: const EdgeInsets.all(16.0),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10.0,
//                   mainAxisSpacing: 10.0,
//                   childAspectRatio: (screenSizeWidth / 2) / (screenSizeWidth / 7),
//                 ),
//                 itemCount: taskActions.length,
//                 itemBuilder: (context, index) {
//                   final action = taskActions[index];
//                   if (action.label == toggleScreenAwakeLabel) {
//                     action.didPressed = () {
//                       _statusProvider.updateScreenAwakeStatus();
//                     };
//                   }
//                   return action.button(context);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:device_admin_manager/device_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:secure_wave/features/emergency/providers/emergency_provider.dart';
import 'package:secure_wave/features/emergency/view/emergency_page.dart';
import 'package:secure_wave/lock_screen.dart';
import 'package:secure_wave/providers/app_providers.dart';
import 'package:secure_wave/features/home/views/home_page.dart';
import 'package:secure_wave/providers/app_status_provider/app_status_provider.dart';
import 'package:secure_wave/providers/database_provider.dart';
import 'package:secure_wave/routes/app_routes.dart';
import 'package:secure_wave/services/locator_service.dart';

import 'task_actions.dart';

/// [Note] Testing as admin
// adb shell dpm set-device-owner com.ib.secure/com.ib.device_admin_manager.AppDeviceAdminReceiver

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await const LocatorService().setup();

  initKioskMode();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: locator.get<ScreenAwakeProvider>()),
      ChangeNotifierProvider(create: (_) => LockProvider(dam: locator.get())),
      ChangeNotifierProvider(create: (_) => DatabaseProvider(dbService: locator.get())),
      ChangeNotifierProvider.value(value: locator.get<EmergencyProvider>()),
      ChangeNotifierProvider(create: (_) => AppStatusProvider(locator.get(), locator.get())),
    ],
    child: const MyApp(),
  ));
}

const bootCompletedHandlerStartedKey = "bootCompletedHandlerStarted";
Future<void> enableKioskMode() async {
  try {
    await locator.get<DeviceAdminManager>().setAsLauncher();
    await locator.get<DeviceAdminManager>().lockApp();
    await locator.get<DeviceAdminManager>().setKeepScreenAwake(true);
    locator.get<ScreenAwakeProvider>().updateScreenAwakeStatus(screenState: ScreenAwake());

    await locator.get<DeviceAdminManager>().put(bootCompletedHandlerStartedKey, content: "false");
  } catch (e) {
    print('dam:: enableKioskMode error: $e');
  }
}

Future<void> initKioskMode() async {
  locator.get<DeviceAdminManager>().handleBootCompleted((_) async {
    final startedValue =
        await locator.get<DeviceAdminManager>().get(bootCompletedHandlerStartedKey);
    final isStarted = startedValue == "true";
    print('dam:: handleBootCompleted:: isStarted: $isStarted');
    await locator.get<DeviceAdminManager>().put(bootCompletedHandlerStartedKey, content: "true");
    if (!isStarted) {
      try {
        await locator.get<DeviceAdminManager>().startApp();
      } catch (e) {
        print('dpc:: handleBootCompleted startApp error: $e');
      }
    }

    // It's important to highlight that if handleBootCompleted was called
    // earlier, dpc.startApp() could make Flutter engine reset (or invalidate)
    // the code to its initial entry point "main".
    // As a result, there's a high probability that the subsequent
    // (next) code lines won't execute as expected.
    // We will not call enableKioskMode method here.
    // enableKioskMode();
  });

  final startedValue = await locator.get<DeviceAdminManager>().get(bootCompletedHandlerStartedKey);
  final isStarted = startedValue == "true";
  print('dpc:: init:: startedValue $startedValue, isStarted: $isStarted');

  if (isStarted) {
    enableKioskMode();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    context.watch<AppStatusProvider>().currentStatus;
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: locator.get<AppRouter>().delegate(),
      routeInformationParser: locator.get<AppRouter>().defaultRouteParser(),
    );
  }
}

// class HomePageX extends StatefulWidget {
//   const HomePageX({super.key});

//   @override
//   State<HomePageX> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePageX> {
//   @override
//   void initState() {
//     super.initState();
//     context.read<ScreenAwakeProvider>().updateScreenAwakeStatus();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenSizeWidth = MediaQuery.sizeOf(context).width;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Device Policy Controller Example'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               locator
//                   .get<DeviceAdminManager>()
//                   .setKeepScreenAwake(!context.read<ScreenAwakeProvider>().isScreenAwake)
//                   .then(
//                 (value) {
//                   context
//                       .read<ScreenAwakeProvider>()
//                       .updateScreenAwakeStatus(screenState: ScreenNotAwake());
//                 },
//               );
//             },
//             child: Consumer<ScreenAwakeProvider>(builder: (context, statusProvider, _) {
//               return Icon(
//                 Icons.flash_on,
//                 color: statusProvider.isScreenAwake ? Colors.amberAccent : Colors.blueGrey,
//                 size: 36,
//               );
//             }),
//           ),
//           const SizedBox(width: 12),
//         ],
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//               child: GridView.builder(
//                 padding: const EdgeInsets.all(16.0),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 10.0,
//                   mainAxisSpacing: 10.0,
//                   childAspectRatio: (screenSizeWidth / 2) / (screenSizeWidth / 7),
//                 ),
//                 itemCount: taskActions.length,
//                 itemBuilder: (context, index) {
//                   final action = taskActions[index];
//                   if (action.label == toggleScreenAwakeLabel) {
//                     action.didPressed = () {
//                       context.read<ScreenAwakeProvider>().updateScreenAwakeStatus();
//                     };
//                   }
//                   return action.button(context);
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
