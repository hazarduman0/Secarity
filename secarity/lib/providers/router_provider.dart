import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:secarity/providers/route_controller_provider.dart';
import 'package:secarity/providers/states/app_states.dart';
import 'package:secarity/ui/home_screen.dart';
import 'package:secarity/ui/login_screen.dart';
import 'package:secarity/ui/register_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifer(ref);
  return GoRouter(
      debugLogDiagnostics: true,
      refreshListenable: router,
      redirect: router._redirectLogic,
      routes: router._routes);
});

class RouterNotifer extends ChangeNotifier {
  final Ref _ref;

  RouterNotifer(this._ref) {
    _ref.listen<AppState>(
        routeControllerProvider, (_, __) => notifyListeners());
  }

  FutureOr<String?> _redirectLogic(BuildContext context, GoRouterState state) {
    final loginState = _ref.read(routeControllerProvider);

    final isLoggingIn = state.location == '/login';

    if (loginState is RegisterState) {
      return '/register';
    }

    // if (loginState is LoginStateInitial) {
    //   return isLoggingIn ? null : '/login';
    // }

    if (loginState is LoginStateInitial) {
      return '/login';
    }

    if (loginState is LoginStateSucces) return '/';

    //print(isLoggingIn);

    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
            name: 'register',
            builder: (context, state) => const RegisterScreen(),
            path: '/register'),
        GoRoute(
            name: 'login',
            builder: (context, state) => const LoginScreen(),
            path: '/login'),
        GoRoute(
            name: 'home',
            builder: (context, state) => const HomeScreen(),
            path: '/'),
      ];
}
