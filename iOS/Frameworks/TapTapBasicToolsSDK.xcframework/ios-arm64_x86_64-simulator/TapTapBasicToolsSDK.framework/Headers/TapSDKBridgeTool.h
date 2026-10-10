//
//  BridgeTool.h
//  EngineBridge
//
//  Created by xe on 2020/10/9.
//  Copyright © 2020 xe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TapSDKBridgeTool : NSObject

+ (BOOL)isEmpty:(NSString *)str;

+ (NSString *)jsonStringWithString:(NSString *)string;

+ (NSString *)jsonStringWithArray:(NSArray *)array;

+ (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary;

+ (NSString *)jsonStringWithObject:(id)model;

+ (NSString *)jsonStringWithMutaDic:(NSDictionary *)dic;

+ (NSDictionary *)dictionaryWithModel:(id)model;

/**
 * 同 jsonStringWithObject:，但对通过 ObjC runtime 反射得到的模型属性名做 key 转换：
 * useSnakeCase=YES 时将 camelCase 属性名转换为 snake_case（如 nextPage -> next_page）；
 * keyAliases 用于覆盖不符合规则转换的个别字段（如 openId -> openid，而不是 open_id）。
 * 仅影响“模型对象反射”得到的 key，不影响调用方手写的 NSDictionary literal 的 key。
 * 注意：Swift 侧未标注 @objc 的属性（如某些 Optional<Int64> 属性）对 ObjC runtime 不可见，
 * 反射天然拿不到这些字段，这不是本方法能解决的问题。
 */
+ (NSString *)jsonStringWithObject:(id)object
                usingSnakeCaseKeys:(BOOL)useSnakeCase
                        keyAliases:(NSDictionary<NSString *, NSString *> * _Nullable)keyAliases;

+ (NSDictionary *)dictionaryWithModel:(id)model
                    usingSnakeCaseKeys:(BOOL)useSnakeCase
                            keyAliases:(NSDictionary<NSString *, NSString *> * _Nullable)keyAliases;

@end

