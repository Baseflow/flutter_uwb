// Autogenerated from Pigeon (v3.1.6), do not edit directly.
// See also: https://pub.dev/packages/pigeon
#import <Foundation/Foundation.h>
@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BFMCEncryptionPreferenceWrapper) {
  BFMCEncryptionPreferenceWrapperOptional = 0,
  BFMCEncryptionPreferenceWrapperRequired = 1,
  BFMCEncryptionPreferenceWrapperNone = 2,
};

@class BFMCPeerIDWrapper;
@class BFMCSessionWrapper;

@interface BFMCPeerIDWrapper : NSObject
+ (instancetype)makeWithDisplayname:(nullable NSString *)displayname;
@property(nonatomic, copy, nullable) NSString * displayname;
@end

@interface BFMCSessionWrapper : NSObject
+ (instancetype)makeWithPeerId:(nullable BFMCPeerIDWrapper *)peerId
    encryptionPreference:(BFMCEncryptionPreferenceWrapper)encryptionPreference;
@property(nonatomic, strong, nullable) BFMCPeerIDWrapper * peerId;
@property(nonatomic, assign) BFMCEncryptionPreferenceWrapper encryptionPreference;
@end

/// The codec used by BFMCNearbyServiceAdvertiserDelegateFlutterApi.
NSObject<FlutterMessageCodec> *BFMCNearbyServiceAdvertiserDelegateFlutterApiGetCodec(void);

@interface BFMCNearbyServiceAdvertiserDelegateFlutterApi : NSObject
- (instancetype)initWithBinaryMessenger:(id<FlutterBinaryMessenger>)binaryMessenger;
- (void)didNotStartAdvertisingPeerWithCompletion:(void(^)(NSError *_Nullable))completion;
- (void)didReceiveInvitationFromPeerPeerID:(BFMCPeerIDWrapper *)peerID context:(nullable NSString *)context completion:(void(^)(BFMCSessionWrapper *_Nullable, NSError *_Nullable))completion;
@end
/// The codec used by BFMCNearbyServiceAdvertiserHostApi.
NSObject<FlutterMessageCodec> *BFMCNearbyServiceAdvertiserHostApiGetCodec(void);

@protocol BFMCNearbyServiceAdvertiserHostApi
/// @return `nil` only when `error != nil`.
- (nullable NSNumber *)checkPlatformCompatibilityWithError:(FlutterError *_Nullable *_Nonnull)error;
- (void)createInstanceId:(NSNumber *)instanceId peerId:(BFMCPeerIDWrapper *)peerId info:(nullable NSDictionary<NSString *, NSString *> *)info serviceType:(NSString *)serviceType error:(FlutterError *_Nullable *_Nonnull)error;
- (void)disposeInstanceId:(NSNumber *)instanceId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)registerDelegateInstanceId:(NSNumber *)instanceId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)removeDelegateInstanceId:(NSNumber *)instanceId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)startAdvertisingPeerInstanceId:(NSNumber *)instanceId error:(FlutterError *_Nullable *_Nonnull)error;
- (void)stopAdvertisingPeerInstanceId:(NSNumber *)instanceId error:(FlutterError *_Nullable *_Nonnull)error;
@end

extern void BFMCNearbyServiceAdvertiserHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<BFMCNearbyServiceAdvertiserHostApi> *_Nullable api);

/// The codec used by BFMCSessionHostApi.
NSObject<FlutterMessageCodec> *BFMCSessionHostApiGetCodec(void);

@protocol BFMCSessionHostApi
@end

extern void BFMCSessionHostApiSetup(id<FlutterBinaryMessenger> binaryMessenger, NSObject<BFMCSessionHostApi> *_Nullable api);

NS_ASSUME_NONNULL_END
