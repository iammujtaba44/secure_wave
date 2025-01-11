part of 'app_providers.dart';

sealed class ProviderState {}

class Initial extends ProviderState {}

class Loading extends ProviderState {}

class Loaded extends ProviderState {}

class Error extends ProviderState {
  final String message;
  Error(this.message);
}

class Empty extends ProviderState {}

class Lock extends ProviderState {}

class UnLock extends ProviderState {}

class ScreenAwake extends ProviderState {}

class ScreenNotAwake extends ProviderState {}

mixin ProviderStateMixin on ChangeNotifier {
  ProviderState _state = Initial();

  ProviderState get state => _state;

  void setState(ProviderState newState) {
    _state = newState;
    notifyListeners();
  }

  bool get isLoading => _state is Loading;
  bool get isLoaded => _state is Loaded;
  bool get isEmpty => _state is Empty;
  bool get isError => _state is Error;
  bool get isInitial => _state is Initial;
  bool get isLock => _state is Lock;
  bool get isUnLock => _state is UnLock;
  bool get isScreenAwake => _state is ScreenAwake;
  bool get isScreenNotAwake => _state is ScreenNotAwake;
}
