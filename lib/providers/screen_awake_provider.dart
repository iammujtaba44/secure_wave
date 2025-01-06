part of 'app_providers.dart';

class ScreenAwakeProvider with ChangeNotifier, ProviderStateMixin {
  final DeviceAdminManager _dam;

  ScreenAwakeProvider({required DeviceAdminManager dam}) : _dam = dam;

  Future<void> updateScreenAwakeStatus({ProviderState? screenState}) async {
    if (screenState != null) setState(screenState);

    bool result = await _dam.isScreenAwake();

    setState(result ? ScreenAwake() : ScreenNotAwake());
  }
}
