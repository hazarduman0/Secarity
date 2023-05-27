import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:secarity/constants/app_keys.dart';
import 'package:secarity/providers/shared_utility_provider.dart';

class AuthService {
  var dio = Dio();
  Ref ref;

  AuthService({required this.ref});

  Future<String> login(String email, String password) async { 
    try {
      var response = await dio.post(loginUrl,
          data: {'email': email, 'password': password});

      final token = response.data['data']['token'];

      ref.read(sharedUtilityProvider).setToken(token);

      log(response.statusCode.toString());

      return token;
    } on DioError catch (e) {
      return e.response!.statusCode.toString();
    }
  }

  Future<int?> register(String deviceID, String email, String password) async {
    try {
      var response = await dio.post(registerUrl,
          data: {'device': deviceID, 'email': email, 'password': password});

      return response.statusCode;
    } on DioError catch (e) {
      log('register error: $e');
      return e.response!.statusCode;
    }
  }
}

final authServiceProvider =
    Provider<AuthService>((ref) => AuthService(ref: ref));
