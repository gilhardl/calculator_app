import 'package:calculator/calculator.dart';
import 'package:test/test.dart';

/// Calculator unit tests

// Unit tests could be run with the following command
// $ flutter test
void main() {
  // Organize tests in groups
  group('Calculator', () {
    late Calculator calculator;
    // Helper functions
    setUpAll(() {
      // Will be executed once before any test runs
      calculator = Calculator();
    });
    setUp(() {
      // Will be executed before every test
    });
    tearDown(() {
      // Will be executed after every test
    });
    tearDownAll(() {
      // Will be executed once after every test ran
    });

    // A unit test
    test('should return 4 when adding 2 and 2', () {
      // Step 1 : Setup -> prepare everithing needed to run the test
      final specificCalculator = Calculator();

      // Step 2 : Side effect -> collect the result to test
      final result = specificCalculator.add(2, 2);

      // Step 3 : Exceptations -> compare the result to the expected value
      expect(result, 4);
    });

    test('should return 10 when multiplying 5 by 2', () {
      expect(calculator.multiply(5, 2), 10);
    });

    test('should return 2.5 when dividing 5 by 2', () {
      expect(calculator.divide(5, 2), 2.5);
    });

    test('should return 2 when substracting 3 to 5', () {
      // We can pass a reason to argument our test exceptation, this reason will be printed on test failure
      expect(calculator.substract(5, 3), 2, reason: 'It should be exactly 2');
    });

    // expect() function works with matchers to ensure the provided result match the expected value
    test('should create a non-null object', () {
      expect(Calculator(), isNotNull);
    });

    test('should return a double number when multiplying 2 and 2', () {
      expect(calculator.multiply(2, 2), isA<double>());
    });

    // To expect an operation throw an exception, we need to wrap the side effect code in an anonymous
    // function in order to allow the expect function to run our code inside an internal try/catch
    test('should throw an ArgumentError when dividing by 0', () {
      expect(() => calculator.divide(10, 0), throwsArgumentError);
    });

    // Futures should be tested using async/await
    test('should return 81 for square of 9', () async {
      expect(await calculator.square(9), 81);
    });

    // Streams could be tested using specific matchers
    test('should emits PI values in order', () {
      expect(calculator.pi(), emitsInOrder([3, 3.1, 3.14, 3.141, 3.1415]));
    });
  });
}
