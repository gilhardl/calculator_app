import 'package:flutter_driver/driver_extension.dart';

import 'package:calculator_app/main.dart' as calculator_app;

/// Instrumented version of our Calculator application in order to work in Flutter driver
void main() {
  enableFlutterDriverExtension();
  calculator_app.main();
}
