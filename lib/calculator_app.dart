import 'package:flutter/material.dart';

import 'keys.dart';
import 'ui/screens/home_screen.dart';

/// The calculator application
///
/// A simple flutter app to learn testing
class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      home: HomeScreen(
        key: Key(kHomeScreenKey),
      ),
    );
  }
}
