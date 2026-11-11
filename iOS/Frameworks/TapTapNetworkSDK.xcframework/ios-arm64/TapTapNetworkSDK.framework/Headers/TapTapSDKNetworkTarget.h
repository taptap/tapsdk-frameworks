//
//  TapTapNetworkTarget.h
//  TapTapSDKCore
//
//  Created by wangzhenbiao on 2024/4/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^TapTapNetworkCallBack)(NSDictionary * _Nullable json, NSURLResponse * _Nullable response, NSError * _Nullable error);

// 重试策略枚举
typedef NS_ENUM(NSInteger, TapTapRetryStrategy) {
    // 默认情况三种情况会重试 1、HTTP Status Code 大于等于 500。2、请求超时。3、无网络。
    // 默认（不传）：对 GET 接口重试三次, 对 POST 接口不重试
    TapTapRetryStrategyDefault,
    // 不重试，无论请求方法都不重试
    TapTapRetryStrategyNoRetry,
    // 重试 3 次，无论请求方法都最多重试 3 次
    TapTapRetryStrategyThreeTimes,
    // 指数退避策略：第一次间隔 2s 后重试，第二次间隔 4s，第三次间隔 8s，直到最大间隔 600s。无最大重试次数限制。
    TapTapRetryStrategyExponentialBackoff,
    // 指数退避策略，间隔规则与 TapTapRetryStrategyExponentialBackoff 相同，但最多尝试 4 次
    // （1 次首发 + 3 次重试），达到上限后不再重试，直接走完成回调。
    TapTapRetryStrategyExponentialBackoffLimited
};

typedef NS_ENUM(NSInteger, TapTapHTTPRequestMethod) {
    TapTapHTTPRequestMethodGET,
    TapTapHTTPRequestMethodPOST,
};

typedef NS_ENUM(NSInteger, TapTapHTTPBodyDataType) {
    TapTapHTTPBodyDataTypeJSON,
    TapTapHTTPBodyDataTypeForm
};

@interface TapTapSDKNetworkTarget : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) TapTapHTTPRequestMethod method;
/// 参数数据类型
@property (nonatomic, assign) TapTapHTTPBodyDataType dataType;

/// 只针对 Post 请求生效
@property (nonatomic, copy) NSDictionary * _Nullable parameters;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nullable header;
// 需要加到 url 后的 query 列表
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nullable queries;
@property (nonatomic, assign) NSTimeInterval delay;
/// 单次请求的总超时（秒，包含连接和响应传输）；大于 0 时生效。
/// 默认 0，沿用共享 Session 的 10 秒配置；不包含重试及调度等待时间。
@property (nonatomic, assign) NSTimeInterval timeoutInterval;
@property (nonatomic, assign) TapTapRetryStrategy retryStrategy;
@property (nonatomic, copy) TapTapNetworkCallBack callback;
@property (nonatomic, strong) dispatch_queue_t _Nullable callbackQueue;
/// 是否需要签名
@property (nonatomic, assign) BOOL isNeedSign;
/// 是否需要登录的授权信息
@property (nonatomic, assign) BOOL isNeedLoginAuthorization;

- (NSData *)generateBody;
- (NSString *)contentType;

- (NSString *)fullURL;

- (NSString *)getSdkModule;
@end

NS_ASSUME_NONNULL_END
