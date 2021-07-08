import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:calculator/calculator.dart';

import 'package:calculator_app/keys.dart';
import 'package:calculator_app/ui/components/two_numbers_operation.dart';

// Mocks can be generated thanks to the @GenerateMocks annotation and the following command
// $ pub run build_runner build
import 'two_numbers_operation_test.mocks.dart';

@GenerateMocks([Calculator])
void main() {
  late MockCalculator calculator;

  setUp(() {
    calculator = MockCalculator();
  });

  group('TwoNumbersOperation', () {
    testWidgets('shows addition result given two numbers', (WidgetTester tester) async {
      when(calculator.add(3, 7)).thenReturn(10.0);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TwoNumbersOperation(
            firstTextfieldKey: Key(kAddOperationFirstTextfieldKey),
            secondTextfieldKey: Key(kAddOperationSecondTextfieldKey),
            calculator: calculator,
            operation: CalculatorTwoNumbersOperation.add,
          ),
        ),
      ));

      await tester.enterText(find.byKey(Key(kAddOperationFirstTextfieldKey)), '3');
      await tester.enterText(find.byKey(Key(kAddOperationSecondTextfieldKey)), '7');
      await tester.pump();

      expect(find.text('= 10.0'), findsOneWidget);
    });

    testWidgets('shows substraction result given two numbers', (WidgetTester tester) async {
      when(calculator.substract(12, 4)).thenReturn(8);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TwoNumbersOperation(
            firstTextfieldKey: Key(kSubstractOperationFirstTextfieldKey),
            secondTextfieldKey: Key(kSubstractOperationSecondTextfieldKey),
            calculator: calculator,
            operation: CalculatorTwoNumbersOperation.substract,
          ),
        ),
      ));

      await tester.enterText(find.byKey(Key(kSubstractOperationFirstTextfieldKey)), '12');
      await tester.enterText(find.byKey(Key(kSubstractOperationSecondTextfieldKey)), '4');
      await tester.pump();
      expect(find.text('= 8.0'), findsOneWidget);
    });

    testWidgets('shows multiplication result given two numbers', (WidgetTester tester) async {
      when(calculator.multiply(3, 2)).thenReturn(6);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TwoNumbersOperation(
            firstTextfieldKey: Key(kMultiplyOperationFirstTextfieldKey),
            secondTextfieldKey: Key(kMultiplyOperationSecondTextfieldKey),
            calculator: calculator,
            operation: CalculatorTwoNumbersOperation.multiply,
          ),
        ),
      ));

      await tester.enterText(find.byKey(Key(kMultiplyOperationFirstTextfieldKey)), '3');
      await tester.enterText(find.byKey(Key(kMultiplyOperationSecondTextfieldKey)), '2');
      await tester.pump();
      expect(find.text('= 6.0'), findsOneWidget);
    });

    testWidgets('shows division result given two numbers', (WidgetTester tester) async {
      when(calculator.divide(5, 2)).thenReturn(2.5);
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: TwoNumbersOperation(
            firstTextfieldKey: Key(kDivideOperationFirstTextfieldKey),
            secondTextfieldKey: Key(kDivideOperationSecondTextfieldKey),
            calculator: calculator,
            operation: CalculatorTwoNumbersOperation.divide,
          ),
        ),
      ));

      await tester.enterText(find.byKey(Key(kDivideOperationFirstTextfieldKey)), '5');
      await tester.enterText(find.byKey(Key(kDivideOperationSecondTextfieldKey)), '2');
      await tester.pump();
      expect(find.text('= 2.5'), findsOneWidget);
    });
  });
}
