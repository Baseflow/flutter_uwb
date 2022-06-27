import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uwb_ios/uwb_ios.dart';

void main() {
  const MethodChannel channel = MethodChannel('uwb_ios');

  TestWidgetsFlutterBinding.ensureInitialized();

  final UwbIos _plugin = UwbIos();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await _plugin.platformVersion, '42');
  });
}
