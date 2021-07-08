import 'package:calculator/calculator.dart';

const kUsage = '''
Usage: dart run bin/calculator.dart <command> <a> [<b>]

Available commands:
  add             Add a + b
  substract       Substract a - b
  multiply        Multiply a * b
  divide          Divide a / b (b couldn't be 0)
  square          Calculate square value of a
  pi              Print PI values
''';

void main(List<String> arguments) async {
  final calculator = Calculator();

  if (arguments.isEmpty) {
    printHelp();
    throw ArgumentError();
  }

  final operation = arguments[0];
  if (!['add', 'substract', 'multiply', 'divide', 'square', 'pi'].contains(operation)) {
    printHelp();
    throw ArgumentError();
  }

  late double a, b;
  if ([
    'add',
    'substract',
    'multiply',
    'divide',
  ].contains(operation)) {
    try {
      a = double.parse(arguments[1]);
      b = double.parse(arguments[2]);
    } catch (_) {
      throw ArgumentError('Numbers required.');
    }
  } else if (operation == 'square') {
    try {
      a = double.parse(arguments[1]);
    } catch (_) {
      throw ArgumentError('Number required.');
    }
  }

  try {
    final result = operation == 'add'
        ? calculator.add(a, b)
        : operation == 'substract'
            ? calculator.substract(a, b)
            : operation == 'multiply'
                ? calculator.multiply(a, b)
                : operation == 'divide'
                    ? calculator.divide(a, b)
                    : operation == 'square'
                        ? await calculator.square(a)
                        : calculator.pi();

    if (result is double) {
      print('Result : $result');
    } else if (result is Stream<double>) {
      print('Result :');
      result.listen(print);
    } else {
      throw Error();
    }
  } on ArgumentError catch (e) {
    print(e.message);
    rethrow;
  } catch (e) {
    printHelp();
    rethrow;
  }
}

void printHelp() => print(kUsage);
