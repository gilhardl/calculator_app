/// Tiny number calculator with basic dart features
class Calculator {
  final List<double> _piValues = [3, 3.1, 3.14, 3.141, 3.1415];

  double add(double a, double b) => a + b;

  double substract(double a, double b) => a - b;

  double multiply(double a, double b) => a * b;

  double divide(double a, double b) {
    if (b == 0) throw ArgumentError('Cannot divide by 0.');
    return a / b;
  }

  Future<double> square(double a) => Future.delayed(const Duration(milliseconds: 100), () => a * a);

  Stream<double> pi() => Stream.periodic(const Duration(milliseconds: 200), (int computation) => _piValues[computation])
      .take(_piValues.length);
}

/// Calculator available operations with two number
enum CalculatorTwoNumbersOperation {
  add,
  substract,
  multiply,
  divide,
}
