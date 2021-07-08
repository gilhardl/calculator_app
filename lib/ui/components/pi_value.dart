import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calculator/calculator.dart';

/// A widget to display PI value
class PiValue extends StatefulWidget {
  final Calculator calculator;

  const PiValue({
    Key? key,
    required this.calculator,
  }) : super(key: key);

  @override
  _PiValueState createState() => _PiValueState();
}

class _PiValueState extends State<PiValue> {
  double? result;

  @override
  void initState() {
    super.initState();
    widget.calculator.pi().listen((double piValue) {
      setState(() {
        result = piValue;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Text(
            'PI',
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                result != null ? '= ${result!.toString()}' : '= ???',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
                // textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
