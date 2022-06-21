import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/uwb_api.pigeon.dart',
  dartTestOut: 'test/uwb_api.pigeon.dart',
  objcHeaderOut: 'ios/Classes/uwb_api.pigeon.h',
  objcSourceOut: 'ios/Classes/uwb_api.pigeon.m',
  objcOptions: ObjcOptions(
    prefix: 'BF',
  ),
))
@HostApi()
abstract class MCNearbyServiceAdvertiserHostApi {
  bool checkPlatformCompatibility();
}

@HostApi()
abstract class MCSessionHostApi {
  
}
