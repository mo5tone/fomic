import 'dart:convert';

import 'package:crypto/crypto.dart' as crypto;
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
