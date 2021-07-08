import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'package:calculator/calculator.dart';

import 'package:calculator_app/ui/components/pi_value.dart';

// Mocks can be generated thanks to the @GenerateMocks annotation and the following command
// $ pub run build_runner build
import 'pi_value_test.mocks.dart';

@GenerateMocks([Calculator])
void main() {
  late MockCalculator calculator;
  final List<double> _piValues = [3, 3.1, 3.14, 3.141, 3.1415];

  setUp(() {
    calculator = MockCalculator();
  });

  group('PiValue', () {
    testWidgets('shows PI value', (WidgetTester tester) async {
      when(calculator.pi()).thenAnswer(
        (_) => Stream.periodic(const Duration(milliseconds: 200), (int computation) => _piValues[computation])
            .take(_piValues.length),
      );
      await tester.pumpWidget(MaterialApp(
        home: Scaffold(
          body: PiValue(
            calculator: calculator,
          ),
        ),
      ));

      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('= 3.1415'), findsOneWidget);
    });
  });
}
