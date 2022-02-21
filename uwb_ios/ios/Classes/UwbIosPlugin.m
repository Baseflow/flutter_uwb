#import "UwbIosPlugin.h"
#if __has_include(<uwb_ios/uwb_ios-Swift.h>)
#import <uwb_ios/uwb_ios-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "uwb_ios-Swift.h"
#endif

@implementation UwbIosPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUwbIosPlugin registerWithRegistrar:registrar];
}
@end
