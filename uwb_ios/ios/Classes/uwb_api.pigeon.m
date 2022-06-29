// Autogenerated from Pigeon (v3.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "uwb_api.pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ?: [NSNull null]),
        @"message": (error.message ?: [NSNull null]),
        @"details": (error.details ?: [NSNull null]),
        };
  }
  return @{
      @"result": (result ?: [NSNull null]),
      @"error": errorDict,
      };
}
static id GetNullableObject(NSDictionary* dict, id key) {
  id result = dict[key];
  return (result == [NSNull null]) ? nil : result;
}
static id GetNullableObjectAtIndex(NSArray* array, NSInteger key) {
  id result = array[key];
  return (result == [NSNull null]) ? nil : result;
}



@interface BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReader : FlutterStandardReader
@end
@implementation BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReader
@end

@interface BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecWriter : FlutterStandardWriter
@end
@implementation BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecWriter
@end

@interface BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *BFMCNearbyServiceAdvertiserDelegateFlutterApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReaderWriter *readerWriter = [[BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


@interface BFMCNearbyServiceAdvertiserDelegateFlutterApi ()
@property (nonatomic, strong) NSObject<FlutterBinaryMessenger> *binaryMessenger;
@end

@implementation BFMCNearbyServiceAdvertiserDelegateFlutterApi

- (instancetype)initWithBinaryMessenger:(NSObject<FlutterBinaryMessenger> *)binaryMessenger {
  self = [super init];
  if (self) {
    _binaryMessenger = binaryMessenger;
  }
  return self;
}
- (void)didNotStartAdvertisingPeerWithCompletion:(void(^)(NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.MCNearbyServiceAdvertiserDelegateFlutterApi.didNotStartAdvertisingPeer"
      binaryMessenger:self.binaryMessenger
      codec:BFMCNearbyServiceAdvertiserDelegateFlutterApiGetCodec()];
  [channel sendMessage:nil reply:^(id reply) {
    completion(nil);
  }];
}
@end
@interface BFMCPeerIDHostApiCodecReader : FlutterStandardReader
@end
@implementation BFMCPeerIDHostApiCodecReader
@end

@interface BFMCPeerIDHostApiCodecWriter : FlutterStandardWriter
@end
@implementation BFMCPeerIDHostApiCodecWriter
@end

@interface BFMCPeerIDHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation BFMCPeerIDHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[BFMCPeerIDHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[BFMCPeerIDHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *BFMCPeerIDHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    BFMCPeerIDHostApiCodecReaderWriter *readerWriter = [[BFMCPeerIDHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void BFMCPeerIDHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<BFMCPeerIDHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCPeerIDHostApi.create"
        binaryMessenger:binaryMessenger
        codec:BFMCPeerIDHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(createInstanceId:displayName:error:)], @"BFMCPeerIDHostApi api (%@) doesn't respond to @selector(createInstanceId:displayName:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        NSString *arg_displayName = GetNullableObjectAtIndex(args, 1);
        FlutterError *error;
        [api createInstanceId:arg_instanceId displayName:arg_displayName error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCPeerIDHostApi.dispose"
        binaryMessenger:binaryMessenger
        codec:BFMCPeerIDHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(disposeInstanceId:error:)], @"BFMCPeerIDHostApi api (%@) doesn't respond to @selector(disposeInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api disposeInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface BFMCSessionHostApiCodecReader : FlutterStandardReader
@end
@implementation BFMCSessionHostApiCodecReader
@end

@interface BFMCSessionHostApiCodecWriter : FlutterStandardWriter
@end
@implementation BFMCSessionHostApiCodecWriter
@end

@interface BFMCSessionHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation BFMCSessionHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[BFMCSessionHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[BFMCSessionHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *BFMCSessionHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    BFMCSessionHostApiCodecReaderWriter *readerWriter = [[BFMCSessionHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void BFMCSessionHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<BFMCSessionHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCSessionHostApi.create"
        binaryMessenger:binaryMessenger
        codec:BFMCSessionHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(createInstanceId:mcPeerIDInstanceId:encryptionPreference:error:)], @"BFMCSessionHostApi api (%@) doesn't respond to @selector(createInstanceId:mcPeerIDInstanceId:encryptionPreference:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_mcPeerIDInstanceId = GetNullableObjectAtIndex(args, 1);
        BFMCEncryptionPreferenceWrapper arg_encryptionPreference = [GetNullableObjectAtIndex(args, 2) integerValue];
        FlutterError *error;
        [api createInstanceId:arg_instanceId mcPeerIDInstanceId:arg_mcPeerIDInstanceId encryptionPreference:arg_encryptionPreference error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCSessionHostApi.dispose"
        binaryMessenger:binaryMessenger
        codec:BFMCSessionHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(disposeInstanceId:error:)], @"BFMCSessionHostApi api (%@) doesn't respond to @selector(disposeInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api disposeInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface BFMCNearbyServiceAdvertiserHostApiCodecReader : FlutterStandardReader
@end
@implementation BFMCNearbyServiceAdvertiserHostApiCodecReader
@end

@interface BFMCNearbyServiceAdvertiserHostApiCodecWriter : FlutterStandardWriter
@end
@implementation BFMCNearbyServiceAdvertiserHostApiCodecWriter
@end

@interface BFMCNearbyServiceAdvertiserHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation BFMCNearbyServiceAdvertiserHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[BFMCNearbyServiceAdvertiserHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[BFMCNearbyServiceAdvertiserHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *BFMCNearbyServiceAdvertiserHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    BFMCNearbyServiceAdvertiserHostApiCodecReaderWriter *readerWriter = [[BFMCNearbyServiceAdvertiserHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void BFMCNearbyServiceAdvertiserHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<BFMCNearbyServiceAdvertiserHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCNearbyServiceAdvertiserHostApi.create"
        binaryMessenger:binaryMessenger
        codec:BFMCNearbyServiceAdvertiserHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(createInstanceId:mcPeerIDInstanceId:info:serviceType:error:)], @"BFMCNearbyServiceAdvertiserHostApi api (%@) doesn't respond to @selector(createInstanceId:mcPeerIDInstanceId:info:serviceType:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_mcPeerIDInstanceId = GetNullableObjectAtIndex(args, 1);
        NSDictionary<NSString *, NSString *> *arg_info = GetNullableObjectAtIndex(args, 2);
        NSString *arg_serviceType = GetNullableObjectAtIndex(args, 3);
        FlutterError *error;
        [api createInstanceId:arg_instanceId mcPeerIDInstanceId:arg_mcPeerIDInstanceId info:arg_info serviceType:arg_serviceType error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCNearbyServiceAdvertiserHostApi.dispose"
        binaryMessenger:binaryMessenger
        codec:BFMCNearbyServiceAdvertiserHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(disposeInstanceId:error:)], @"BFMCNearbyServiceAdvertiserHostApi api (%@) doesn't respond to @selector(disposeInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api disposeInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCNearbyServiceAdvertiserHostApi.registerDelegate"
        binaryMessenger:binaryMessenger
        codec:BFMCNearbyServiceAdvertiserHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(registerDelegateInstanceId:error:)], @"BFMCNearbyServiceAdvertiserHostApi api (%@) doesn't respond to @selector(registerDelegateInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api registerDelegateInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCNearbyServiceAdvertiserHostApi.removeDelegate"
        binaryMessenger:binaryMessenger
        codec:BFMCNearbyServiceAdvertiserHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(removeDelegateInstanceId:error:)], @"BFMCNearbyServiceAdvertiserHostApi api (%@) doesn't respond to @selector(removeDelegateInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api removeDelegateInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCNearbyServiceAdvertiserHostApi.startAdvertisingPeer"
        binaryMessenger:binaryMessenger
        codec:BFMCNearbyServiceAdvertiserHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(startAdvertisingPeerInstanceId:error:)], @"BFMCNearbyServiceAdvertiserHostApi api (%@) doesn't respond to @selector(startAdvertisingPeerInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api startAdvertisingPeerInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCNearbyServiceAdvertiserHostApi.stopAdvertisingPeer"
        binaryMessenger:binaryMessenger
        codec:BFMCNearbyServiceAdvertiserHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(stopAdvertisingPeerInstanceId:error:)], @"BFMCNearbyServiceAdvertiserHostApi api (%@) doesn't respond to @selector(stopAdvertisingPeerInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api stopAdvertisingPeerInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
@interface BFMCBrowserViewControllerHostApiCodecReader : FlutterStandardReader
@end
@implementation BFMCBrowserViewControllerHostApiCodecReader
@end

@interface BFMCBrowserViewControllerHostApiCodecWriter : FlutterStandardWriter
@end
@implementation BFMCBrowserViewControllerHostApiCodecWriter
@end

@interface BFMCBrowserViewControllerHostApiCodecReaderWriter : FlutterStandardReaderWriter
@end
@implementation BFMCBrowserViewControllerHostApiCodecReaderWriter
- (FlutterStandardWriter *)writerWithData:(NSMutableData *)data {
  return [[BFMCBrowserViewControllerHostApiCodecWriter alloc] initWithData:data];
}
- (FlutterStandardReader *)readerWithData:(NSData *)data {
  return [[BFMCBrowserViewControllerHostApiCodecReader alloc] initWithData:data];
}
@end

NSObject<FlutterMessageCodec> *BFMCBrowserViewControllerHostApiGetCodec() {
  static dispatch_once_t sPred = 0;
  static FlutterStandardMessageCodec *sSharedObject = nil;
  dispatch_once(&sPred, ^{
    BFMCBrowserViewControllerHostApiCodecReaderWriter *readerWriter = [[BFMCBrowserViewControllerHostApiCodecReaderWriter alloc] init];
    sSharedObject = [FlutterStandardMessageCodec codecWithReaderWriter:readerWriter];
  });
  return sSharedObject;
}


void BFMCBrowserViewControllerHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<BFMCBrowserViewControllerHostApi> *api) {
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCBrowserViewControllerHostApi.create"
        binaryMessenger:binaryMessenger
        codec:BFMCBrowserViewControllerHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(createInstanceId:mCSessionInstanceID:serviceType:error:)], @"BFMCBrowserViewControllerHostApi api (%@) doesn't respond to @selector(createInstanceId:mCSessionInstanceID:serviceType:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        NSNumber *arg_mCSessionInstanceID = GetNullableObjectAtIndex(args, 1);
        NSString *arg_serviceType = GetNullableObjectAtIndex(args, 2);
        FlutterError *error;
        [api createInstanceId:arg_instanceId mCSessionInstanceID:arg_mCSessionInstanceID serviceType:arg_serviceType error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCBrowserViewControllerHostApi.dispose"
        binaryMessenger:binaryMessenger
        codec:BFMCBrowserViewControllerHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(disposeInstanceId:error:)], @"BFMCBrowserViewControllerHostApi api (%@) doesn't respond to @selector(disposeInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api disposeInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCBrowserViewControllerHostApi.registerDelegate"
        binaryMessenger:binaryMessenger
        codec:BFMCBrowserViewControllerHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(registerDelegateInstanceId:error:)], @"BFMCBrowserViewControllerHostApi api (%@) doesn't respond to @selector(registerDelegateInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api registerDelegateInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCBrowserViewControllerHostApi.removeDelegate"
        binaryMessenger:binaryMessenger
        codec:BFMCBrowserViewControllerHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(removeDelegateInstanceId:error:)], @"BFMCBrowserViewControllerHostApi api (%@) doesn't respond to @selector(removeDelegateInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api removeDelegateInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
  {
    FlutterBasicMessageChannel *channel =
      [[FlutterBasicMessageChannel alloc]
        initWithName:@"dev.flutter.pigeon.MCBrowserViewControllerHostApi.presentTheBrowserToViewController"
        binaryMessenger:binaryMessenger
        codec:BFMCBrowserViewControllerHostApiGetCodec()        ];
    if (api) {
      NSCAssert([api respondsToSelector:@selector(presentTheBrowserToViewControllerInstanceId:error:)], @"BFMCBrowserViewControllerHostApi api (%@) doesn't respond to @selector(presentTheBrowserToViewControllerInstanceId:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        FlutterError *error;
        [api presentTheBrowserToViewControllerInstanceId:arg_instanceId error:&error];
        callback(wrapResult(nil, error));
      }];
    }
    else {
      [channel setMessageHandler:nil];
    }
  }
}
