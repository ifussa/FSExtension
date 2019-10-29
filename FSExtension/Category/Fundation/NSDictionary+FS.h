//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (FS)

/**
 * 转换成NSData
 */
- (NSData *)fs_data;
/**
 *字典转json
 */
- (NSString *)fs_dictionaryToJson;

/**
 *字典转json
 */
+ (NSString *)fs_dictionaryToJson:(NSDictionary *)dictionary;
@end


@interface NSMutableDictionary (FS)

#pragma mark - 安全操作字典
- (void)fs_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)fs_safeRemoveObjectForKey:(id)aKey;

@end

