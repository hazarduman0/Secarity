import 'dart:convert';
import 'dart:math';
import 'dart:developer' as devo;

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:secarity/models/thief_data.dart';
import 'package:secarity/utilities/enums.dart';

String generateRandomString(int length) {
  var random = Random();
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
}

Map<String, dynamic> extractMessage(String message) {
  int first = 0;
  int last = 0;
  String text = message.substring(3, message.length - 4);

  for (int index = 0; index < text.length - 4; index++) {
    if (text.substring(index, index + 3) == '\\n{') {
      first = index + 1;
    }
    if (text.substring(index, index + 3) == '}\\u') {
      last = index + 1;
    }
  }

  text = text.substring(first + 1, last);
  text = text.replaceAll('\\', '');

  Map<String, dynamic> json = jsonDecode(text);
  devo.log(json.toString());

  return json;
}

double scaleTempurateValue(int value) {
  return value.toDouble() / 50.0;
}

double scaleHumidityValue(int value) {
  return value.toDouble() / 100.0;
}

List<FlSpot>? getFlSpots(List<ThiefData>? thiefDataList, FlType flType) {
  if (thiefDataList == null || thiefDataList.isEmpty) return [];

  List<FlSpot> flSpotList = [];

  var k = 0;

  for (int i = 0; i < thiefDataList.length; i++) {
    if (thiefDataList[i].status == 'Alarm Susturuldu') continue;

    final value = flType == FlType.humidity
        ? thiefDataList[i].humidityValue!.toDouble()
        : thiefDataList[i].temperatureValue!.toDouble();

    double doubleK = k + .0;

    final flSpot = FlSpot(doubleK, value);
    flSpotList.add(flSpot);

    k++;
  }
  
  return flSpotList;
}

  List<String> rowStringList(ThiefData thiefData){
    List<String> stringList = [];
    stringList.add("Thief");
    stringList.add("${thiefData.temperatureValue}°C");
    stringList.add("%${thiefData.humidityValue}");
    stringList.add(thiefData.motionValue! ? "Detected" : "-");
    stringList.add(extractDate(thiefData.time.toString()));
    return stringList;
  }

  String extractDate(String dateTimeString) {
  String date = dateTimeString.substring(0, 10);
  return date;
}


double changeMargin(double value, Size size) {
  const minValue = -20.0;
  const maxValue = 70.0;
  final width = size.shortestSide * 0.7;
  final scaledValue = (value - minValue) / (maxValue - minValue) * 100;

  return width * (scaledValue / 100);
}

Color changeColor(double value, double minValue, double maxValue, Color begin, Color end) {
  final scaledValue = (value - minValue) / (maxValue - minValue) * 100;

  return ColorTween(
    begin: begin,
    end: end,
  ).lerp(scaledValue / 100)!.withOpacity(1.0);
}
