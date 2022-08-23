import 'package:flutter_js/flutter_js.dart';

String eval(String code) => getJavascriptRuntime().evaluate(code).stringResult;
