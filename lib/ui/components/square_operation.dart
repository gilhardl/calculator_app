import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:calculator/calculator.dart';

/// A widget to make square operations
class SquareOperation extends StatefulWidget {
  final Key? textfieldKey;
  final Calculator calculator;

  const SquareOperation({
    Key? key,
    this.textfieldKey,
    required this.calculator,
  }) : super(key: key);

  @override
  _SquareOperationState createState() => _SquareOperationState();
}

class _SquareOperationState extends State<SquareOperation> {
  double? numberA;
  double? operationResult;
  final aCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    aCtrl.addListener(() async {
      final number = double.tryParse(aCtrl.text);
      if (number != numberA) {
        final result = await getOperationResult(number);
        setState(() {
          numberA = number;
          operationResult = result;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            key: widget.textfieldKey,
            controller: aCtrl,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '2',
            style: TextStyle(
              fontFeatures: [FontFeature.enable('sups')],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              operationResult != null ? '= ${operationResult!.toString()}' : '= ???',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    aCtrl.dispose();
    super.dispose();
  }

  Future<double?> getOperationResult(double? a) async {
    if (a != null) {
      try {
        return await widget.calculator.square(a);
      } catch (e) {
        return null;
      }
    } else
      return null;
  }
}
