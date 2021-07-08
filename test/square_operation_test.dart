import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:calculator/calculator.dart';

import 'package:calculator_app/keys.dart';
import 'package:calculator_app/ui/components/square_operation.dart';

// Mocks can be generated thanks to the @GenerateMocks annotation and the following command
// $ pub run build_runner build
import 'square_operation_test.mocks.dart';

@GenerateMocks([Calculator])
void main() {
  late MockCalculator calculator;

  setUp(() {
    calculator = MockCalculator();
  });

  group('SquareOperation', () {
    testWidgets('shows square result given a numbers', (WidgetTester tester) async {
      when(calculator.square(5)).thenAnswer((_) => Future.delayed(const Duration(milliseconds: 100), () => 25));
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: SquareOperation(
            textfieldKey: Key(kSquareOperationTextfieldKey),
            calculator: calculator,
          ),
        ),
      ));

      await tester.enterText(find.byKey(Key(kSquareOperationTextfieldKey)), '5');
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('= 25.0'), findsOneWidget);
    });
  });
}
