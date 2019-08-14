import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:device_info/device_info.dart';
import 'package:intl/intl.dart';

String md5(String input) => crypto.md5.convert(utf8.encode(input)).toString();

String dateTime2String(DateTime input,
        [String pattern = 'yyyy-MM-dd HH:mm:ss']) =>
    DateFormat(pattern).format(input);

DateTime string2DateTime(String input,
        [String pattern = 'yyyy-MM-dd HH:mm:ss']) =>
    DateFormat(pattern).parse(input);

String fixScheme(String url, [String scheme = 'http']) {
  if (url.startsWith('//')) {
    return '$scheme:$url';
  }
  return url;
}

Future<bool> get isWifi {
  return Connectivity()
      .checkConnectivity()
      .then((result) => result == ConnectivityResult.wifi);
}

Future<String> get wifiIP => isWifi.then((value) async {
      if (value) {
        final DeviceInfoPlugin infoPlugin = DeviceInfoPlugin();
        final iosInfo = await infoPlugin.iosInfo;
        final androidInfo = await infoPlugin.androidInfo;
        if ((iosInfo != null && !iosInfo.isPhysicalDevice) ||
            (androidInfo != null && !androidInfo.isPhysicalDevice)) {
          return '0.0.0.0';
        } else {
          return await Connectivity().getWifiIP();
        }
      } else {
        return null;
      }
    });
