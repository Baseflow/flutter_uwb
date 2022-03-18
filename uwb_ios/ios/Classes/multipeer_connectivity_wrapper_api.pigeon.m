// Autogenerated from Pigeon (v2.0.2), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import "multipeer_connectivity_wrapper_api.pigeon.h"
#import <Flutter/Flutter.h>

#if !__has_feature(objc_arc)
#error File requires ARC to be enabled.
#endif

static NSDictionary<NSString *, id> *wrapResult(id result, FlutterError *error) {
  NSDictionary *errorDict = (NSDictionary *)[NSNull null];
  if (error) {
    errorDict = @{
        @"code": (error.code ? error.code : [NSNull null]),
        @"message": (error.message ? error.message : [NSNull null]),
        @"details": (error.details ? error.details : [NSNull null]),
        };
  }
  return @{
      @"result": (result ? result : [NSNull null]),
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


@interface BFMCPeerIDWrapper ()
+ (BFMCPeerIDWrapper *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end
@interface BFMCSessionWrapper ()
+ (BFMCSessionWrapper *)fromMap:(NSDictionary *)dict;
- (NSDictionary *)toMap;
@end

@implementation BFMCPeerIDWrapper
+ (instancetype)makeWithDisplayName:(nullable NSString *)displayName {
  BFMCPeerIDWrapper* pigeonResult = [[BFMCPeerIDWrapper alloc] init];
  pigeonResult.displayName = displayName;
  return pigeonResult;
}
+ (BFMCPeerIDWrapper *)fromMap:(NSDictionary *)dict {
  BFMCPeerIDWrapper *pigeonResult = [[BFMCPeerIDWrapper alloc] init];
  pigeonResult.displayName = GetNullableObject(dict, @"displayName");
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.displayName ? self.displayName : [NSNull null]), @"displayName", nil];
}
@end

@implementation BFMCSessionWrapper
+ (instancetype)makeWithPeerId:(nullable BFMCPeerIDWrapper *)peerId
    encryptionPreference:(BFMCEncryptionPreferenceWrapper)encryptionPreference {
  BFMCSessionWrapper* pigeonResult = [[BFMCSessionWrapper alloc] init];
  pigeonResult.peerId = peerId;
  pigeonResult.encryptionPreference = encryptionPreference;
  return pigeonResult;
}
+ (BFMCSessionWrapper *)fromMap:(NSDictionary *)dict {
  BFMCSessionWrapper *pigeonResult = [[BFMCSessionWrapper alloc] init];
  pigeonResult.peerId = [BFMCPeerIDWrapper fromMap:GetNullableObject(dict, @"peerId")];
  pigeonResult.encryptionPreference = [GetNullableObject(dict, @"encryptionPreference") integerValue];
  return pigeonResult;
}
- (NSDictionary *)toMap {
  return [NSDictionary dictionaryWithObjectsAndKeys:(self.peerId ? [self.peerId toMap] : [NSNull null]), @"peerId", @(self.encryptionPreference), @"encryptionPreference", nil];
}
@end

@interface BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReader : FlutterStandardReader
@end
@implementation BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [BFMCPeerIDWrapper fromMap:[self readValue]];
    
    case 129:     
      return [BFMCSessionWrapper fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecWriter : FlutterStandardWriter
@end
@implementation BFMCNearbyServiceAdvertiserDelegateFlutterApiCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[BFMCPeerIDWrapper class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
  if ([value isKindOfClass:[BFMCSessionWrapper class]]) {
    [self writeByte:129];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
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
- (void)didReceiveInvitationFromPeerPeerID:(BFMCPeerIDWrapper *)arg_peerID context:(nullable NSString *)arg_context completion:(void(^)(BFMCSessionWrapper *_Nullable, NSError *_Nullable))completion {
  FlutterBasicMessageChannel *channel =
    [FlutterBasicMessageChannel
      messageChannelWithName:@"dev.flutter.pigeon.MCNearbyServiceAdvertiserDelegateFlutterApi.didReceiveInvitationFromPeer"
      binaryMessenger:self.binaryMessenger
      codec:BFMCNearbyServiceAdvertiserDelegateFlutterApiGetCodec()];
  [channel sendMessage:@[(arg_peerID == nil) ? [NSNull null] : arg_peerID, (arg_context == nil) ? [NSNull null] : arg_context] reply:^(id reply) {
    BFMCSessionWrapper *output = reply;
    completion(output, nil);
  }];
}
@end
@interface BFMCNearbyServiceAdvertiserHostApiCodecReader : FlutterStandardReader
@end
@implementation BFMCNearbyServiceAdvertiserHostApiCodecReader
- (nullable id)readValueOfType:(UInt8)type 
{
  switch (type) {
    case 128:     
      return [BFMCPeerIDWrapper fromMap:[self readValue]];
    
    default:    
      return [super readValueOfType:type];
    
  }
}
@end

@interface BFMCNearbyServiceAdvertiserHostApiCodecWriter : FlutterStandardWriter
@end
@implementation BFMCNearbyServiceAdvertiserHostApiCodecWriter
- (void)writeValue:(id)value 
{
  if ([value isKindOfClass:[BFMCPeerIDWrapper class]]) {
    [self writeByte:128];
    [self writeValue:[value toMap]];
  } else 
{
    [super writeValue:value];
  }
}
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
      NSCAssert([api respondsToSelector:@selector(createInstanceId:peerId:info:serviceType:error:)], @"BFMCNearbyServiceAdvertiserHostApi api (%@) doesn't respond to @selector(createInstanceId:peerId:info:serviceType:error:)", api);
      [channel setMessageHandler:^(id _Nullable message, FlutterReply callback) {
        NSArray *args = message;
        NSNumber *arg_instanceId = GetNullableObjectAtIndex(args, 0);
        BFMCPeerIDWrapper *arg_peerId = GetNullableObjectAtIndex(args, 1);
        NSDictionary<NSString *, NSString *> *arg_info = GetNullableObjectAtIndex(args, 2);
        NSString *arg_serviceType = GetNullableObjectAtIndex(args, 3);
        FlutterError *error;
        [api createInstanceId:arg_instanceId peerId:arg_peerId info:arg_info serviceType:arg_serviceType error:&error];
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
