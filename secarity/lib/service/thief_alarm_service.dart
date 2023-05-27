import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/constants/app_keys.dart';
import 'package:secarity/models/thief_data.dart';
import 'package:secarity/models/unique_params.dart';

class ThiefAlarmService {
  var dio = Dio();

  Future<List<ThiefData>?> getThiefRecords(String token) async {
    try {
      var response = await dio.get(thiefAlarmUrl,
          options: Options(headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        if (response.data != null) {
          List<ThiefData> thiefDatas = [];
          for (int i = 0; i < response.data['data'].length; i++) {
            final thiefData = ThiefData.fromJson(response.data['data'][i]);
            thiefDatas.add(thiefData);
          }
          return thiefDatas;
        }
      }
    } catch (e) {
      log('Thief Alarm Service Error: $e');
    }
  }

  Future<List<ThiefData>?> getThiefPaginationRecords(
      String token, int offset, int pageSize) async {
    try {
      var response = await dio.get(thiefAlaramPaginationUrl(offset, pageSize),
          options: Options(headers: {
            'accept': 'application/json',
            'Authorization': 'Bearer $token'
          }));

      if (response.statusCode == 200) {
        if (response.data != null) {
          List<ThiefData> thiefDatas = [];
          for (int i = 0; i < response.data['data'].length; i++) {
            final thiefData = ThiefData.fromJson(response.data['data'][i]);
            thiefDatas.add(thiefData);
          }
          return thiefDatas;
        }
      }
    } catch (e) {
      log('Thief Alarm Service Error: $e');
    }
  }
}

final thiefAlarmServiceProvider =
    Provider<ThiefAlarmService>((ref) => ThiefAlarmService());

final getThiefRecordsProvider =
    FutureProvider.family<List<ThiefData>?, UniqueParams>((ref, params) {
  var thiefAlarmService = ref.read(thiefAlarmServiceProvider);
  return thiefAlarmService.getThiefRecords(params.token);
});

final getThiefPaginationRecordsProvider =
    FutureProvider.family<List<ThiefData>?, UniqueParams>((ref, params) {
  var thiefAlarmService = ref.read(thiefAlarmServiceProvider);
  return thiefAlarmService.getThiefPaginationRecords(
      params.token, params.offset!, params.pageSize!);
});
