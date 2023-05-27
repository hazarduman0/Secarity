import 'package:secarity/models/fire_alarm.dart';
import 'package:secarity/models/distance.dart';
import 'package:secarity/models/motion.dart';
import 'package:secarity/models/tempurate_humidity.dart';
import 'package:secarity/models/thief_alarm.dart';
import 'package:secarity/models/vibration.dart';
import 'package:secarity/utilities/enums.dart';

extension WsString on WsType {
  String getWsString() {
    switch (this) {
      case WsType.distance:
        {
          return 'mesafe';
        }
      case WsType.fire:
        {
          return 'yangin';
        }
      case WsType.motion:
        {
          return 'hareket';
        }
      case WsType.thief:
        {
          return 'hirsiz';
        }
      case WsType.tempurateHumidity:
        {
          return 'sicaklik-nem';
        }
      case WsType.vibration:
        {
          return 'titresim';
        }
      default:
        return 'unknown';
    }
  }

  Object getWsObj(Map<String, dynamic> json) {
    switch (this) {
      case WsType.distance:
        {
          return Distance.fromJson(json);
        }
      case WsType.fire:
        {
          return FireAlarm.fromJson(json);
        }
      case WsType.thief:
        {
          return ThiefAlarm.fromJson(json);
        }

      case WsType.motion:
        {
          return Motion.fromJson(json);
        }

      case WsType.tempurateHumidity:
        {
          return TempurateHumidity.fromJson(json);
        }
      case WsType.vibration:
        {
          return Vibration.fromJson(json);
        }
      default:
        return 'unknown';
    }
  }
}
