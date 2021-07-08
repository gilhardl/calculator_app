import 'dart:io';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'package:calculator_app/keys.dart';

/// CalculatorApp integration tests

// Integration tests could be run on the instrumented version of the CalculatorApp with the following command
// $ flutter drive --target=test_driver/calculator_app.dart
void main() {
  late FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() {
    driver.close();
  });

  group('CalculatorApp', () {
    test('automatically shows PI value, every time a new value is resolved', () async {
      // Wait until the PI value shows up on the screen
      await driver.waitFor(find.text('PI value'));
      await driver.waitFor(find.text('= ???'));
      await driver.waitFor(find.text('= 3.0'));
      await driver.waitFor(find.text('= 3.1'));
      await driver.waitFor(find.text('= 3.14'));
      await driver.waitFor(find.text('= 3.141'));
      await driver.waitFor(find.text('= 3.1415'));
      await driver.takeScreenshot('pi/01');
    });

    test('shows 10 when adding 7 to 3', () async {
      // Interact with the instrumented app
      await driver.tap(find.byValueKey(kAddOperationFirstTextfieldKey));
      await driver.enterText('3');
      await driver.takeScreenshot('addition/01');
      await driver.tap(find.byValueKey(kAddOperationSecondTextfieldKey));
      await driver.enterText('7');
      await driver.takeScreenshot('addition/02');

      // Wait until the operation result shows up on the screen
      await driver.waitFor(find.text('= 10.0'));
    });

    test('shows 8 when substracting 4 to 12', () async {
      await driver.tap(find.byValueKey(kSubstractOperationFirstTextfieldKey));
      await driver.enterText('12');
      await driver.takeScreenshot('substraction/01');
      await driver.tap(find.byValueKey(kSubstractOperationSecondTextfieldKey));
      await driver.enterText('4');
      await driver.takeScreenshot('substraction/02');

      await driver.waitFor(find.text('= 8.0'));
    });

    test('shows 6 when multiplying 3 by 2', () async {
      await driver.tap(find.byValueKey(kMultiplyOperationFirstTextfieldKey));
      await driver.enterText('3');
      await driver.takeScreenshot('multiplication/01');
      await driver.tap(find.byValueKey(kMultiplyOperationSecondTextfieldKey));
      await driver.enterText('2');
      await driver.takeScreenshot('multiplication/02');

      await driver.waitFor(find.text('= 6.0'));
    });

    test('shows 2.5 when dividing 5 by 2', () async {
      await driver.tap(find.byValueKey(kDivideOperationFirstTextfieldKey));
      await driver.enterText('5');
      await driver.takeScreenshot('division/01');
      await driver.tap(find.byValueKey(kDivideOperationSecondTextfieldKey));
      await driver.enterText('2');
      await driver.takeScreenshot('division/02');

      await driver.waitFor(find.text('= 2.5'));
    });

    test('shows 25 when calculating the square of 5', () async {
      await driver.tap(find.byValueKey(kSquareOperationTextfieldKey));
      await driver.enterText('5');

      await driver.waitFor(find.text('= 25.0'));

      await driver.takeScreenshot('square/01');
    });
  });
}

extension on FlutterDriver {
  Future<void> takeScreenshot(String name) async {
    final file = File('screenshots/$name.png');
    if (file.existsSync()) file.deleteSync(recursive: true);
    file.createSync(recursive: true);
    file.writeAsBytesSync(await screenshot());
  }
}
