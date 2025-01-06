part of 'app_providers.dart';

class LockProvider with ChangeNotifier, ProviderStateMixin {
  final DeviceAdminManager _dam;

  LockProvider({required DeviceAdminManager dam}) : _dam = dam;

  Future<void> lockApp({String? message}) async {
    bool result = await _dam.lockApp();
    if (result) {
      setState(Lock());
    } else {
      setState(Error('Failed to lock app'));
    }
  }

  void unlockApp() async {
    bool result = await _dam.lockApp();
    if (result) {
      setState(UnLock());
    } else {
      setState(Error('Failed to un lock app'));
    }
  }
}
