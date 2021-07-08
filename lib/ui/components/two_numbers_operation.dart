import 'package:flutter/material.dart';
import 'package:calculator/calculator.dart';

/// A widget to make operations with 2 numbers (add, substract, multiply and divide)
class TwoNumbersOperation extends StatefulWidget {
  final Key? firstTextfieldKey;
  final Key? secondTextfieldKey;
  final Calculator calculator;
  final CalculatorTwoNumbersOperation operation;

  const TwoNumbersOperation({
    Key? key,
    this.firstTextfieldKey,
    this.secondTextfieldKey,
    required this.calculator,
    required this.operation,
  }) : super(key: key);

  @override
  _TwoNumbersOperationState createState() => _TwoNumbersOperationState();
}

class _TwoNumbersOperationState extends State<TwoNumbersOperation> {
  double? numberA;
  double? numberB;
  double? operationResult;
  final aCtrl = TextEditingController();
  final bCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    aCtrl.addListener(() {
      final number = double.tryParse(aCtrl.text);
      if (number != numberA) {
        setState(() {
          numberA = number;
          operationResult = getOperationResult(numberA, numberB);
        });
      }
    });
    bCtrl.addListener(() {
      final number = double.tryParse(bCtrl.text);
      if (number != numberB) {
        setState(() {
          numberB = number;
          operationResult = getOperationResult(numberA, numberB);
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
            key: widget.firstTextfieldKey,
            controller: aCtrl,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.operation == CalculatorTwoNumbersOperation.add
                ? '+'
                : widget.operation == CalculatorTwoNumbersOperation.substract
                    ? '-'
                    : widget.operation == CalculatorTwoNumbersOperation.multiply
                        ? 'x'
                        : '/',
            style: TextStyle(
              fontSize: 24.0,
            ),
          ),
        ),
        Expanded(
          child: TextField(
            key: widget.secondTextfieldKey,
            controller: bCtrl,
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 120.0,
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
    bCtrl.dispose();
    super.dispose();
  }

  double? getOperationResult(double? a, double? b) {
    if (a != null && b != null) {
      try {
        return widget.operation == CalculatorTwoNumbersOperation.add
            ? widget.calculator.add(a, b)
            : widget.operation == CalculatorTwoNumbersOperation.substract
                ? widget.calculator.substract(a, b)
                : widget.operation == CalculatorTwoNumbersOperation.multiply
                    ? widget.calculator.multiply(a, b)
                    : widget.calculator.divide(a, b);
      } catch (e) {
        return null;
      }
    } else
      return null;
  }
}
