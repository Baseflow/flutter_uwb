import 'package:flutter/services.dart';

class MCalculatorWrapper {
  static const MethodChannel _channel = MethodChannel('com.baseflow.uwb/math_calculator');

  Future <int> increment(int value) async {
    final int? incrementedValue = await _channel.invokeMethod('MCalculator.increment', value);
    return incrementedValue ?? value;
  }
}