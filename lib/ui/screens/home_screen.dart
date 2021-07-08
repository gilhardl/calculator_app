import 'package:flutter/material.dart';

import 'package:calculator/calculator.dart';

import '../../keys.dart';
import '../components/two_numbers_operation.dart';
import '../components/pi_value.dart';
import '../components/square_operation.dart';

/// The main Calculator screen
class HomeScreen extends StatelessWidget {
  final calculator = Calculator();

  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculator'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              OperationTitle(text: 'Add'),
              TwoNumbersOperation(
                key: Key(kAddOperationKey),
                firstTextfieldKey: Key(kAddOperationFirstTextfieldKey),
                secondTextfieldKey: Key(kAddOperationSecondTextfieldKey),
                calculator: calculator,
                operation: CalculatorTwoNumbersOperation.add,
              ),
              Divider(),
              OperationTitle(text: 'Substract'),
              TwoNumbersOperation(
                key: Key(kSubstractOperationKey),
                firstTextfieldKey: Key(kSubstractOperationFirstTextfieldKey),
                secondTextfieldKey: Key(kSubstractOperationSecondTextfieldKey),
                calculator: calculator,
                operation: CalculatorTwoNumbersOperation.substract,
              ),
              Divider(),
              OperationTitle(text: 'Multiply'),
              TwoNumbersOperation(
                key: Key(kMultiplyOperationKey),
                firstTextfieldKey: Key(kMultiplyOperationFirstTextfieldKey),
                secondTextfieldKey: Key(kMultiplyOperationSecondTextfieldKey),
                calculator: calculator,
                operation: CalculatorTwoNumbersOperation.multiply,
              ),
              Divider(),
              OperationTitle(text: 'Divide'),
              TwoNumbersOperation(
                key: Key(kDivideOperationKey),
                firstTextfieldKey: Key(kDivideOperationFirstTextfieldKey),
                secondTextfieldKey: Key(kDivideOperationSecondTextfieldKey),
                calculator: calculator,
                operation: CalculatorTwoNumbersOperation.divide,
              ),
              Divider(),
              OperationTitle(text: 'Square'),
              SquareOperation(
                key: Key(kSquareOperationKey),
                textfieldKey: Key(kSquareOperationTextfieldKey),
                calculator: calculator,
              ),
              Divider(),
              OperationTitle(text: 'PI value'),
              PiValue(
                key: Key(kPiValueKey),
                calculator: calculator,
              ),
            ],
          ),
        ));
  }
}

class OperationTitle extends StatelessWidget {
  final String text;

  const OperationTitle({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Text(
      text,
      style: textTheme.headline6,
    );
  }
}
