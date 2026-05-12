//
//  THEMISLite.h
//  XDGameSafety
//
//  Created by sxf on 2024/3/14.
//

#ifndef _THEMISLite_H_
#define _THEMISLite_H_

#include <stdio.h>
#include <stdint.h>
/**
 * @brief Themis Lite 回调接口类.
 *
 * 用于接收 Themis 初始化后异步返回的 TDID 和 GID 数据。
 */
#ifdef __cplusplus
class ThemisLiteCallback
{
public:
    /**
     * @brief TDID 回调函数.
     *
     * 当 Themis 初始化成功并生成 TDID 时调用此函数。ios平台返回空字符串("")
     *
     * @param tdid [in] 生成的 TDID 字符串，UTF-8编码，NUL结尾。
     */
    virtual void tdidCallback(const char* tdid) = 0;

    /**
     * @brief GID 数据回调函数.
     *
     * 当 Themis 初始化成功获取 GID 数据时调用此函数。
     *
     * @param gidData [in] GID 数据字符串，UTF-8编码，NUL结尾。
     */
    virtual void gidDataCallback(const char* gidData) = 0;
};
#endif // __cplusplus

#ifdef __cplusplus
extern "C" {
__attribute__ ((visibility ("default")))
/**
 * @brief 初始化 Themis 版本 3.
 *
 * @param appId      [in]  应用程序标识，项目名称，最大长度 31 字符。
 *                      若传入 NULL 或空字符串，默认值为 "themis_lite"。
 * @param callback   [in]  回调接口指针。初始化成功后，tdid 和 gidData 通过回调返回。
 * @param preGid     [in]  之前通过 gidData 获取的 gid 值，作为预先信息传入。
 * @param timeOut    [in]  异步等待超时时间，单位毫秒 (ms)，推荐设置为 300 ms。
 */
void InitThemis_v3(const char* appId, ThemisLiteCallback* callback, const char* preGid, uint64_t timeOut);
}
#endif

#ifdef __OBJC__

#import <Foundation/Foundation.h>
/**
 * @brief Themis Lite 回调接口类(ThemisLiteCallback),OC代理.
 *
 * 用于接收 Themis 初始化后异步返回的 TDID 和 GID 数据。
 */
__attribute__ ((visibility ("default")))
@protocol ThemisLiteCallbackProtocol <NSObject>
- (void)tdidCallback:(NSString *)tdid;
- (void)gidDataCallback:(NSString *)gidData;
@end

NS_ASSUME_NONNULL_BEGIN

__attribute__ ((visibility ("default")))
@interface THEMISLite : NSObject
/**
 * @brief OC 初始化 Themis 版本 3.
 *
 * @param appId      [in]  应用程序标识，项目名称，最大长度 31 字符。
 *                      若传入 NULL 或空字符串，默认值为 "themis_lite"。
 * @param callback   [in]  回调接口指针。初始化成功后，tdid 和 gidData 通过回调返回。
 * @param preGid     [in]  之前通过 gidData 获取的 gid 值，作为预先信息传入。
 * @param timeOut    [in]  异步等待超时时间，单位毫秒 (ms)，推荐设置为 300 ms。
 */
+ (void)InitThemis_v3:(NSString *)appId
                        callback:(id<ThemisLiteCallbackProtocol>)callback
                        preGid:(NSString *)preGid
                        timeOut:(long)timeOut;
@end

NS_ASSUME_NONNULL_END
#endif

#endif /* _THEMISLite_H_ */
