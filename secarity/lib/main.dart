import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/constants/app_strings.dart';
import 'package:secarity/providers/router_provider.dart';
import 'package:secarity/providers/shared_utility_provider.dart';
import 'package:secarity/theme/theme_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final sharedPreferences = await SharedPreferences.getInstance();
  
  runApp(ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false, home: SecarityApp())));
}

class SecarityApp extends ConsumerWidget {
  const SecarityApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    Size size = MediaQuery.of(context).size;
    return MaterialApp.router(
      title: AppString.appTitle,
      debugShowCheckedModeBanner: false,
      theme: lightTheme(size),
      darkTheme: lightTheme(size),
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
