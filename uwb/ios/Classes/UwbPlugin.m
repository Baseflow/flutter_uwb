#import "UwbPlugin.h"
#if __has_include(<uwb/uwb-Swift.h>)
#import <uwb/uwb-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "uwb-Swift.h"
#endif

@implementation UwbPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftUwbPlugin registerWithRegistrar:registrar];
}
@end
