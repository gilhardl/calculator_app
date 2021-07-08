# Calculator

A tiny pure Dart calculator with basic features to demonstrate how unit testing works :
- Structure of a unit test
- Compare results to expected values using the expect() method and matchers
- Organize tests
- Testing exceptions
- Testing futures
- Testing streams

The calculator can also be run in the CLI from the package root foler.

```
dart run bin/calculator.dart <command> <a> [<b>]

Available commands:
  add             Add a + b
  substract       Substract a - b
  multiply        Multiply a * b
  divide          Divide a / b (b couldn't be 0)
  square          Calculate square value of a
  pi              Print PI values
```
