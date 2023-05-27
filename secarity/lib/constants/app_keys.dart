import 'package:secarity/utilities/enums.dart';
import 'package:secarity/utilities/extension.dart';
import 'package:secarity/utilities/helper.dart';

const baseWsUrl = 'websocketUrl :)';
const sendWs = '$baseWsUrl/gonder';

const baseHttpUrl = 'baseUrl :)';
const thiefAlarmAddition = '/api/thiefalarm/findall';
const loginAddition = '/api/user/login';
const registerAddition = '/user/register';

String thiefAlarmPaginationAddition(int offset, int pageSize) => '/api/thiefalarm/findall/$offset/$pageSize';


String randomAndWs() =>
    '/${generateRandomString(3)}/${generateRandomString(8)}/websocket';

String getWsUrl(String name, WsType wsType) =>
    '$sendWs/${wsType.getWsString()}/$name${randomAndWs()}';

String connectUrl(String token) =>
    "[\"CONNECT\\nAuthorization:Bearer $token\\naccept-version:1.1,1.0\\nheart-beat:10000,10000\\n\\n\\u0000\"]";

String subscribeUrl(WsType wsType, String name) =>
    "[\"SUBSCRIBE\\nid:sub-0\\ndestination:/al/${wsType.getWsString()}/$name\\n\\n\\u0000\"]";

String sendUrl(WsType wsType, String name, String token, int value) =>
    "[\"SEND\\nAuthorization:Bearer $token\\ndestination:/gonder/${wsType.getWsString()}/$name\\n\\n{\\\"value\\\":\\\"${value.toString()}\\\",\\\"temperatureValue\\\":\\\"23\\\",\\\"humidityValue\\\":\\\"32\\\",\\\"distanceValue\\\":\\\"22\\\",\\\"motionValue\\\":\\\"1\\\",\\\"vibrationValue\\\":\\\"0\\\"}\\u0000\"]";

String get thiefAlarmUrl => baseHttpUrl + thiefAlarmAddition;
String get loginUrl => baseHttpUrl + loginAddition;
String get registerUrl => baseHttpUrl + registerAddition;

String thiefAlaramPaginationUrl(int offset, int pageSize) => baseHttpUrl + thiefAlarmPaginationAddition(offset, pageSize);
