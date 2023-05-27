import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/providers/states/app_states.dart';
import 'package:secarity/repository/auth_repository.dart';

class RouteController extends StateNotifier<AppState> {
  RouteController(this.ref) : super(const LoginStateInitial());

  final Ref ref;

  void login(String email, String password) async {
    state = const LoginStateLoading();

    try {
      var response =
          await ref.read(authRepositoryProvider).login(email, password);
      ref.read(sharedUtilityProvider).setEmail(email);
      ref.read(sharedUtilityProvider).setPassword(password);

      log('Response: $response');

      if(response == '400'){
        state = const LoginStateInitial();
        return;
      }

      state = const LoginStateSucces();
    } catch (e) {
      state = LoginStateError(e.toString());
      log('login Error: $e');
    }
  }

  void autoLogin() async {
    final String? token = ref.read(sharedUtilityProvider).getToken();

    log('token here: $token');

    if (token == null) {
      state = const LoginStateInitial();
      return;
    }

    final String? email = ref.read(sharedUtilityProvider).getEmail();
    final String? password = ref.read(sharedUtilityProvider).getPassword();

    if (email == null || password == null) {
      state = const LoginStateInitial();
      return;
    }

    try {
      var response =
          await ref.read(authRepositoryProvider).login(email, password);

      ref.read(sharedUtilityProvider).setToken(response);

      state = const LoginStateSucces();
    } catch (e) {
      state = LoginStateError(e.toString());
      log('auto login Error: $e');
    }
  }

  void routeRegister() {
    state = const RegisterState();
  }

  void routeLogin() {
    state = const LoginStateInitial();
  }

  void logOut() {
    ref.read(sharedUtilityProvider).setToken(null);
    ref.read(sharedUtilityProvider).setEmail(null);
    ref.read(sharedUtilityProvider).setPassword(null);
    state = const LoginStateInitial();
  }
}

final routeControllerProvider =
    StateNotifierProvider<RouteController, AppState>((ref) {
  return RouteController(ref);
});
