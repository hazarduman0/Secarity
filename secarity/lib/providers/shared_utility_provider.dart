import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final sharedUtilityProvider =
    Provider<SharedUtility>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return SharedUtility(sharedPreferences: sharedPrefs);
});

class SharedUtility {
  SharedUtility({required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  String? getToken() {
    return sharedPreferences.getString('token');
  }

  String? getEmail() {
    return sharedPreferences.getString('email');
  }

  String? getPassword() {
    return sharedPreferences.getString('password');
  }

  void setToken(String? tokenKey) {
    if (tokenKey == null) {
      sharedPreferences.remove('token');
      return;
    }
    sharedPreferences.setString('token', tokenKey);
  }

  void setEmail(String? email) {
    if (email == null) {
      sharedPreferences.remove('email');
      return;
    }
    sharedPreferences.setString('email', email);
  }

  void setPassword(String? password) {
    if (password == null) {
      sharedPreferences.remove('password');
      return;
    }
    sharedPreferences.setString('password', password);
  }
}
