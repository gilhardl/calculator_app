import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

import 'package:calculator_app/calculator_app.dart';
import 'package:calculator_app/keys.dart';
import 'package:calculator_app/ui/screens/home_screen.dart';
import 'package:calculator_app/ui/components/two_numbers_operation.dart';
import 'package:calculator_app/ui/components/square_operation.dart';
import 'package:calculator_app/ui/components/pi_value.dart';

/// CalculatorApp widget tests
///
/// This tests are redoundant with isolated widgets tests available in
/// two_numbers_operation_test.dart, square_operation_test.dart and pi_value_test
/// but the interest here is the comments which explain some key features of widget tests
/// Isolated widgets tests also mock dependencies, which is not the case here.

// Widget tests could be run with the following command
// $ flutter test
// Test coverage report could be generated with the following command
// $ flutter test --coverage
// HTML coverage report could be generated with the following command
// $ genhtml ./coverage/lcov.info -o coverage
void main() {
  group('CalculatorApp', () {
    testWidgets('renders HomeScreen', (WidgetTester tester) async {
      // Instantiate and render CalculatorApp
      await tester.pumpWidget(CalculatorApp());

      // Search in the widget tree for a specific widget type
      final homeScreenFinder = find.byType(HomeScreen);

      // Render a new frame after 1 second (in order to wait for the PI stream completes)
      await tester.pump(const Duration(seconds: 1));

      // Expect the finder to locate exactly one widget
      expect(homeScreenFinder, findsOneWidget);
    });

    // Golden files could be generated using the following command
    // $ flutter test --update-goldens
    testWidgets('matches golden file', (WidgetTester tester) async {
      await tester.pumpWidget(CalculatorApp());
      await tester.pump(const Duration(seconds: 1));
      await expectLater(find.byType(CalculatorApp), matchesGoldenFile('goldens/calculator_app.png'));
    });
  });

  group('HomeScreen', () {
    testWidgets('renders 4 CalculatorOperation, SquareOperation and PiValues widgets', (WidgetTester tester) async {
      // Instantiate and render HomeScreen (which should be encapsulated into a MaterialApp to work)
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));

      await tester.pump(const Duration(seconds: 1));
      expect(find.byType(TwoNumbersOperation), findsNWidgets(4));
      expect(find.byType(SquareOperation), findsOneWidget);
      expect(find.byType(PiValue), findsOneWidget);
    });

    testWidgets('shows addition result given two numbers', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 1));

      // Find a widget in the widget tree by searching for a specific key
      final addOperationFinder = find.byKey(Key(kAddOperationKey));
      final firstTextfieldFinder = find.byKey(Key(kAddOperationFirstTextfieldKey));
      final secondTextfieldFinder = find.byKey(Key(kAddOperationSecondTextfieldKey));

      // As the add TwoNumbersOperation is in a ScrollView, we need to ensure the widget is visible
      // by scrolling the ListView so as to make the add TwoNumbersOperation widget visible
      await tester.ensureVisible(addOperationFinder);

      // Interact with the widget by focusing and entering some text to a text input widget
      await tester.enterText(firstTextfieldFinder, '3');

      // We can also manually focus a textfield by tapping it
      await tester.tap(secondTextfieldFinder);
      await tester.enterText(secondTextfieldFinder, '7');

      // Render a new frame to consider textfields update
      await tester.pump();

      // Expect to find text with the add operation result
      expect(find.text('= 10.0'), findsOneWidget);
    });

    testWidgets('shows substraction result given two numbers', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 1));
      await tester.ensureVisible(find.byKey(Key(kSubstractOperationKey)));
      await tester.enterText(find.byKey(Key(kSubstractOperationFirstTextfieldKey)), '12');
      await tester.enterText(find.byKey(Key(kSubstractOperationSecondTextfieldKey)), '4');
      await tester.pump();
      expect(find.text('= 8.0'), findsOneWidget);
    });

    testWidgets('shows multiplication result given two numbers', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 1));
      await tester.ensureVisible(find.byKey(Key(kMultiplyOperationKey)));
      await tester.enterText(find.byKey(Key(kMultiplyOperationFirstTextfieldKey)), '3');
      await tester.enterText(find.byKey(Key(kMultiplyOperationSecondTextfieldKey)), '2');
      await tester.pump();
      expect(find.text('= 6.0'), findsOneWidget);
    });

    testWidgets('shows division result given two numbers', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 1));
      await tester.ensureVisible(find.byKey(Key(kDivideOperationKey)));
      await tester.enterText(find.byKey(Key(kDivideOperationFirstTextfieldKey)), '5');
      await tester.enterText(find.byKey(Key(kDivideOperationSecondTextfieldKey)), '2');
      await tester.pump();
      expect(find.text('= 2.5'), findsOneWidget);
    });

    testWidgets('shows square result given a numbers', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.pump(const Duration(seconds: 1));
      await tester.ensureVisible(find.byKey(Key(kSquareOperationKey)));
      await tester.enterText(find.byKey(Key(kSquareOperationTextfieldKey)), '5');

      // Render a new frame after 100ms because the square operation is asynchronous
      await tester.pump(const Duration(milliseconds: 100));

      expect(find.text('= 25.0'), findsOneWidget);
    });

    testWidgets('shows PI value', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: HomeScreen()));
      await tester.ensureVisible(find.byKey(Key(kPiValueKey)));

      // Repeatedly render new frames during 1 second to be sure the PI value is fully rendered
      //
      // pumpAndSettle() function is also useful to work with animation, but in this case it's not
      // necessary to specify a duration because it can ask the system when the animation is over
      await tester.pumpAndSettle(const Duration(seconds: 1));

      expect(find.text('= 3.1415'), findsOneWidget);
    });
  });
}
