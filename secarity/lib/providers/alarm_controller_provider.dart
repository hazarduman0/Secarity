import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlarmController extends ChangeNotifier {
  bool _isTriggered = false;

  bool get isTriggered => _isTriggered;

  triggerAlarm() {
    _isTriggered = true;
    notifyListeners();
  }

  killAlarm() {
    _isTriggered = false;
    notifyListeners();
  }
}

final alarmControllerProvider =
    ChangeNotifierProvider<AlarmController>((ref) => AlarmController());
