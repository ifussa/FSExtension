//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (FS)

#pragma mark - 加密

/// md5加、解密
- (NSData *)fs_MD5;
- (NSString *)fs_MD5String;
- (NSString *)fs_UTF8String;

/// base64加、解密
- (NSString *)fs_base64EncodedString;
+ (NSData *)fs_dataFromBase64String:(NSString *)base64String;
- (id)fs_initWithBase64String:(NSString *)base64String;

@end