import 'dart:developer' as devo;
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:secarity/constants/app_keys.dart';
import 'package:secarity/models/fire_alarm.dart';
import 'package:secarity/models/distance.dart';
import 'package:secarity/models/motion.dart';
import 'package:secarity/models/tempurate_humidity.dart';
import 'package:secarity/models/thief_alarm.dart';
import 'package:secarity/models/unique_params.dart';
import 'package:secarity/models/vibration.dart';
import 'package:secarity/utilities/enums.dart';
import 'package:secarity/utilities/extension.dart';
import 'package:secarity/utilities/helper.dart';

// class SocketService<T> extends ChangeNotifier {
//   late String name;
//   late String token;
//   late WsType wsType;

//   T? _object;
//   T? get object => _object;

//   set changeValues(T? object) {
//     _object = object;
//     notifyListeners();
//   }

//   wsConnect() async {
//     try {
//       final wSocket = await WebSocket.connect(getWsUrl(name, wsType));
//       wSocket.listen((data) {
//         devo.log('${wsType.name} Socket Listen: $data');
//         if (data.toString() == "o") {
//           wSocket.add(connectUrl(token));
//         }
//         if (data.toString().contains('a["CONNECTED')) {
//           wSocket.add(subscribeUrl(wsType, name));
//         }
//         if (data.toString().contains('a["MESSAGE')) {
//           Map<String, dynamic> json = extractMessage(data.toString());
//           final jsonToObject = wsType.getWsObj(json);
//           changeValues = jsonToObject as T;
//         }
//       });
//     } catch (e) {
//       devo.log('${wsType.name} Error: $e');
//     }
//   }

//   SocketService(
//       {required this.name, required this.token, required this.wsType}) {
//     wsConnect();
//   }
// }

// final socketServiceProvider =
//     ChangeNotifierProvider.family<SocketService, UniqueParams>((ref, params) =>
//         SocketService(
//             name: params.name, token: params.token, wsType: params.wsType));

class FireAlarmSocket extends ChangeNotifier {
  late String name;
  late String token;

  FireAlarm? _alarm = FireAlarm();
  FireAlarm? get alarm => _alarm;

  late WebSocket wSocket;

  set changeValues(FireAlarm? alarm) {
    _alarm = alarm;
    notifyListeners();
  }

  // initSocket(WsType wsType) async {
  //   wSocket = await WebSocket.connect(getWsUrl(name, wsType));
  // }

  wsFireAlarmConnect(WsType wsType) async {
    try {
      wSocket = await WebSocket.connect(getWsUrl(name, wsType));
      wSocket.listen((data) {
        devo.log('${wsType.name} Socket Listen: $data');
        if (data.toString() == "o") {
          wSocket.add(connectUrl(token));
        }
        if (data.toString().contains('a["CONNECTED')) {
          wSocket.add(subscribeUrl(wsType, name));
        }
        if (data.toString().contains('a["MESSAGE')) {
          Map<String, dynamic> json = extractMessage(data.toString());
          changeValues = FireAlarm.fromJson(json);
        }
      });
    } catch (e) {
      devo.log('${wsType.name} Error: $e');
    }
  }

  killAlarm() {
    wSocket.add(sendUrl(WsType.fire, name, token, 0));
  }

  FireAlarmSocket({required this.name, required this.token}) {
    //initSocket(WsType.fire);
    wsFireAlarmConnect(WsType.fire);
  }
}

final fireAlarmSocketProvider =
    ChangeNotifierProvider.family<FireAlarmSocket, UniqueParams>(
        (ref, params) =>
            FireAlarmSocket(name: params.name, token: params.token));

            //throw UnimplementedError();

class ThieftAlarmSocket extends ChangeNotifier {
  late String name;
  late String token;

  ThiefAlarm? _alarm = ThiefAlarm();
  ThiefAlarm? get alarm => _alarm;

  late WebSocket wSocket;

  set changeValues(ThiefAlarm? alarm) {
    _alarm = alarm;
    notifyListeners();
  }

  // initSocket(WsType wsType) async {
  //   wSocket = await WebSocket.connect(getWsUrl(name, wsType));
  // }

  wsThiefAlarmConnect(WsType wsType) async {
    try {
      wSocket = await WebSocket.connect(getWsUrl(name, wsType));
      wSocket.listen((data) {
        devo.log('${wsType.name} Socket Listen: $data');
        if (data.toString() == "o") {
          wSocket.add(connectUrl(token));
        }
        if (data.toString().contains('a["CONNECTED')) {
          wSocket.add(subscribeUrl(wsType, name));
        }
        if (data.toString().contains('a["MESSAGE')) {
          Map<String, dynamic> json = extractMessage(data.toString());
          changeValues = ThiefAlarm.fromJson(json);
        }
      });
    } catch (e) {
      devo.log('${wsType.name} Error: $e');
    }
  }

  killAlarm() {
    wSocket.add(sendUrl(WsType.thief, name, token, 0));
  }

  ThieftAlarmSocket({required this.name, required this.token}) {
    wsThiefAlarmConnect(WsType.thief);
  }
}

final thieftAlarmSocketProvider =
    ChangeNotifierProvider.family<ThieftAlarmSocket, UniqueParams>(
        (ref, params) =>
            ThieftAlarmSocket(name: params.name, token: params.token));

class VibrationSocket extends ChangeNotifier {
  late String name;
  late String token;

  Vibration? _vibration = Vibration();
  Vibration? get vibration => _vibration;

  wsVibrationConnect(WsType wsType) async {
    try {
      final wSocket = await WebSocket.connect(getWsUrl(name, wsType));
      wSocket.listen((data) {
        devo.log('${wsType.name} Socket Listen: $data');
        if (data.toString() == "o") {
          wSocket.add(connectUrl(token));
        }
        if (data.toString().contains('a["CONNECTED')) {
          wSocket.add(subscribeUrl(wsType, name));
        }
        if (data.toString().contains('a["MESSAGE')) {
          Map<String, dynamic> json = extractMessage(data.toString());
          devo.log('${wsType.name} json data : $json');
          _vibration = wsType.getWsObj(json) as Vibration?;
          notifyListeners();
        }
      });
    } catch (e) {
      devo.log('${wsType.name} Error: $e');
    }
  }

  VibrationSocket({required this.name, required this.token}) {
    wsVibrationConnect(WsType.vibration);
  }
}

final vibrationSocketProvider =
    ChangeNotifierProvider.family<VibrationSocket, UniqueParams>(
        (ref, params) =>
            VibrationSocket(name: params.name, token: params.token));

class MotionSocket extends ChangeNotifier {
  late String name;
  late String token;

  Motion? _motion = Motion();
  Motion? get motion => _motion;

  wsMotionConnect(WsType wsType) async {
    try {
      final wSocket = await WebSocket.connect(getWsUrl(name, wsType));
      wSocket.listen((data) {
        devo.log('${wsType.name} Socket Listen: $data');
        if (data.toString() == "o") {
          wSocket.add(connectUrl(token));
        }
        if (data.toString().contains('a["CONNECTED')) {
          wSocket.add(subscribeUrl(wsType, name));
        }
        if (data.toString().contains('a["MESSAGE')) {
          Map<String, dynamic> json = extractMessage(data.toString());
          devo.log('${wsType.name} json data : $json');
          _motion = wsType.getWsObj(json) as Motion?;
          notifyListeners();
        }
      });
    } catch (e) {
      devo.log('${wsType.name} Error: $e');
    }
  }

  MotionSocket({required this.name, required this.token}) {
    wsMotionConnect(WsType.motion);
  }
}

final motionSocketProvider =
    ChangeNotifierProvider.family<MotionSocket, UniqueParams>(
        (ref, params) =>
            MotionSocket(name: params.name, token: params.token));

class DistanceSocket extends ChangeNotifier {
  late String name;
  late String token;

  Distance? _distance = Distance();
  Distance? get distance => _distance;

  wsDistanceConnect(WsType wsType) async {
    try {
      final wSocket = await WebSocket.connect(getWsUrl(name, wsType));
      wSocket.listen((data) {
        devo.log('${wsType.name} Socket Listen: $data');
        if (data.toString() == "o") {
          wSocket.add(connectUrl(token));
        }
        if (data.toString().contains('a["CONNECTED')) {
          wSocket.add(subscribeUrl(wsType, name));
        }
        if (data.toString().contains('a["MESSAGE')) {
          Map<String, dynamic> json = extractMessage(data.toString());
          devo.log('${wsType.name} json data : $json');
          _distance = wsType.getWsObj(json) as Distance?;
          notifyListeners();
        }
      });
    } catch (e) {
      devo.log('${wsType.name} Error: $e');
    }
  }

  DistanceSocket({required this.name, required this.token}) {
    wsDistanceConnect(WsType.distance);
  }
}

final distanceSocketProvider =
    ChangeNotifierProvider.family<DistanceSocket, UniqueParams>(
        (ref, params) =>
            DistanceSocket(name: params.name, token: params.token));

class TempurateHumiditySocket extends ChangeNotifier {
  late String name;
  late String token;

  TempurateHumidity? _tempurateHumidity;
  TempurateHumidity? get tempurateHumidity => _tempurateHumidity;

  set changeValues(TempurateHumidity? tempurateHumidity) {
    _tempurateHumidity = tempurateHumidity;
    devo.log('Maarem: ${_tempurateHumidity!.humidityValue}');
    notifyListeners();
  }

  wsTempurateHumidityConnect(WsType wsType) async {
    try {
      final wSocket = await WebSocket.connect(getWsUrl(name, wsType));
      wSocket.listen((data) {
        devo.log('${wsType.name} Socket Listen: $data');
        if (data.toString() == "o") {
          wSocket.add(connectUrl(token));
        }
        if (data.toString().contains('a["CONNECTED')) {
          wSocket.add(subscribeUrl(wsType, name));
        }
        if (data.toString().contains('a["MESSAGE')) {
          Map<String, dynamic> json = extractMessage(data.toString());
          devo.log('${wsType.name} json data : $json');
          changeValues = TempurateHumidity.fromJson(json);
        }
      });
    } catch (e) {
      devo.log('${wsType.name} Error: $e');
    }
  }

  TempurateHumiditySocket({required this.name, required this.token}) {
    wsTempurateHumidityConnect(WsType.tempurateHumidity);
  }
}

final tempurateHumiditySocketProvider =
    ChangeNotifierProvider.family<TempurateHumiditySocket, UniqueParams>(
        (ref, params) =>
            TempurateHumiditySocket(name: params.name, token: params.token));

final webSocketProvider =
    FutureProvider.family.autoDispose<WebSocket, String>((ref, name) async {
  final socket =
      await WebSocket.connect(getWsUrl(name, WsType.tempurateHumidity));
  ref.onDispose(() => socket.close());
  return socket;
});
