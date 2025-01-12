part of 'main.dart';

class SecureWaveApp extends StatelessWidget {
  const SecureWaveApp({super.key});

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
        print('dam:: handleBootCompleted startApp error: $e');
      }
    }

    // It's important to highlight that if handleBootCompleted was called
    // earlier, dam.startApp() could make Flutter engine reset (or invalidate)
    // the code to its initial entry point "main".
    // As a result, there's a high probability that the subsequent
    // (next) code lines won't execute as expected.
    // We will not call enableKioskMode method here.
    // enableKioskMode();
  });

  final startedValue = await locator.get<DeviceAdminManager>().get(bootCompletedHandlerStartedKey);
  final isStarted = startedValue == "true";
  print('dam:: init:: startedValue $startedValue, isStarted: $isStarted');

  if (isStarted) {
    enableKioskMode();
  }
}
