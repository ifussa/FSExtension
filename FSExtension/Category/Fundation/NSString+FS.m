//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "NSString+FS.h"
#import <CommonCrypto/CommonCrypto.h>

#define EmojiCodeToSymbol(c) ((((0x808080F0 | (c & 0x3F000) >> 4) | (c & 0xFC0) << 10) | (c & 0x1C0000) << 18) | (c & 0x3F) << 24)

@implementation NSString (FS)
- (CGFloat)fs_getHeightWithConstrainedWidth:(CGFloat)width font:(UIFont *)font {
    CGSize constraintRect = CGSizeMake(width, CGFLOAT_MAX);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(boundingBox.size.height);
}
- (CGFloat)fs_getWidthWithConstrainedHeight:(CGFloat)height font:(UIFont *)font {
    CGSize constraintRect = CGSizeMake(CGFLOAT_MAX, height);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(boundingBox.size.width);
}

#pragma mark - 校验

- (BOOL)fs_empty {
    return [self length] > 0 ? NO : YES;
}


- (BOOL)fs_eq:(NSString *)other {
    return [self isEqualToString:other];
}


- (BOOL)fs_isValueOf:(NSArray *)array {
    return [self fs_isValueOf:array caseInsens:NO];
}

- (BOOL)fs_isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens {
    NSStringCompareOptions option = caseInsens ? NSCaseInsensitiveSearch : 0;

    for ( NSObject * obj in array ) {
        if ( NO == [obj isKindOfClass:[NSString class]] )
            continue;

        if ( NSOrderedSame == [(NSString *)obj compare:self options:option] )
            return YES;
    }

    return NO;
}

- (BOOL)fs_isNumber {
    NSString *		regex = @"-?[0-9]+";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    return [pred evaluateWithObject:self];
}

- (BOOL)fs_isEmail {
    NSString *		regex = @"[A-Z0-9a-z._\%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}";
    NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

    return [pred evaluateWithObject:[self lowercaseString]];
}

- (BOOL)fs_isUrl {
    return ([self hasPrefix:@"http://"] || [self hasPrefix:@"https://"]) ? YES : NO;
}

- (BOOL)fs_isIPAddress {

    NSArray *			components = [self componentsSeparatedByString:@"."];
    NSCharacterSet *	invalidCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"1234567890"] invertedSet];

    if ( [components count] == 4 )
    {
        NSString *part1 = [components objectAtIndex:0];
        NSString *part2 = [components objectAtIndex:1];
        NSString *part3 = [components objectAtIndex:2];
        NSString *part4 = [components objectAtIndex:3];

        if ( 0 == [part1 length] ||
                0 == [part2 length] ||
                0 == [part3 length] ||
                0 == [part4 length] )
        {
            return NO;
        }

        if ( [part1 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
                [part2 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
                [part3 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound &&
                [part4 rangeOfCharacterFromSet:invalidCharacters].location == NSNotFound )
        {
            if ( [part1 intValue] <= 255 &&
                    [part2 intValue] <= 255 &&
                    [part3 intValue] <= 255 &&
                    [part4 intValue] <= 255 )
            {
                return YES;
            }
        }
    }

    return NO;
}

- (NSString *)fs_substringFromIndex:(NSUInteger)from untilString:(NSString *)string {

    return [self substringFromIndex:from untilString:string endOffset:NULL];
}

- (NSString *)substringFromIndex:(NSUInteger)from untilString:(NSString *)string endOffset:(NSUInteger *)endOffset {
    if ( 0 == self.length )
        return nil;

    if ( from >= self.length )
        return nil;

    NSRange range = NSMakeRange( from, self.length - from );
    NSRange range2 = [self rangeOfString:string options:NSCaseInsensitiveSearch range:range];

    if ( NSNotFound == range2.location )
    {
        if ( endOffset )
        {
            *endOffset = range.location + range.length;
        }

        return [self substringWithRange:range];
    }
    else
    {
        if ( endOffset )
        {
            *endOffset = range2.location + range2.length;
        }

        return [self substringWithRange:NSMakeRange(from, range2.location - from)];
    }
}

- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset {

    return [self substringFromIndex:from untilCharset:charset endOffset:NULL];
}

- (NSString *)substringFromIndex:(NSUInteger)from untilCharset:(NSCharacterSet *)charset endOffset:(NSUInteger *)endOffset {

    if ( 0 == self.length )
        return nil;

    if ( from >= self.length )
        return nil;

    NSRange range = NSMakeRange( from, self.length - from );
    NSRange range2 = [self rangeOfCharacterFromSet:charset options:NSCaseInsensitiveSearch range:range];

    if ( NSNotFound == range2.location )
    {
        if ( endOffset )
        {
            *endOffset = range.location + range.length;
        }

        return [self substringWithRange:range];
    }
    else
    {
        if ( endOffset )
        {
            *endOffset = range2.location + range2.length;
        }

        return [self substringWithRange:NSMakeRange(from, range2.location - from)];
    }
}

- (NSUInteger)countFromIndex:(NSUInteger)from inCharset:(NSCharacterSet *)charset {

    if ( 0 == self.length )
        return 0;

    if ( from >= self.length )
        return 0;

    NSCharacterSet * reversedCharset = [charset invertedSet];

    NSRange range = NSMakeRange( from, self.length - from );
    NSRange range2 = [self rangeOfCharacterFromSet:reversedCharset options:NSCaseInsensitiveSearch range:range];

    if ( NSNotFound == range2.location )
    {
        return self.length - from;
    }
    else
    {
        return range2.location - from;
    }
}

- (NSArray *)pairSeparatedByString:(NSString *)separator {
    if ( nil == separator )
        return nil;

    NSUInteger	offset = 0;
    NSString *	key = [self substringFromIndex:0 untilCharset:[NSCharacterSet characterSetWithCharactersInString:separator] endOffset:&offset];
    NSString *	val = nil;

    if ( nil == key || offset >= self.length )
        return nil;

    val = [self substringFromIndex:offset];
    if ( nil == val )
        return nil;

    return [NSArray arrayWithObjects:key, val, nil];
}


+ (NSString *)fs_emojiWithIntCode:(long)intCode {
    NSString * s = [NSString stringWithFormat:@"%ld",intCode];
    int symbol = EmojiCodeToSymbol([s intValue]);
    NSString *string = [[NSString alloc] initWithBytes:&symbol length:sizeof(symbol) encoding:NSUTF8StringEncoding];
    if (string == nil) { // 新版Emoji
        string = [NSString stringWithFormat:@"%C", (unichar)intCode];
    }
    return string;
}

- (NSString *)fs_emoji {
    return [NSString fs_emojiWithStringCode:self];
}

+ (NSString *)fs_emojiWithStringCode:(NSString *)stringCode {
    char *charCode = (char *)stringCode.UTF8String;
    long intCode = strtol(charCode, NULL, 16);
    return [self fs_emojiWithIntCode:intCode];
}


// 判断是否是 emoji表情
- (BOOL)fs_isEmoji
{
    BOOL returnValue = NO;

    const unichar hs = [self characterAtIndex:0];
    // surrogate pair
    if (0xd800 <= hs && hs <= 0xdbff) {
        if (self.length > 1) {
            const unichar ls = [self characterAtIndex:1];
            const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
            if (0x1d000 <= uc && uc <= 0x1f77f) {
                returnValue = YES;
            }
        }
    } else if (self.length > 1) {
        const unichar ls = [self characterAtIndex:1];
        if (ls == 0x20e3) {
            returnValue = YES;
        }
    } else {
        // non surrogate
        if (0x2100 <= hs && hs <= 0x27ff) {
            returnValue = YES;
        } else if (0x2B05 <= hs && hs <= 0x2b07) {
            returnValue = YES;
        } else if (0x2934 <= hs && hs <= 0x2935) {
            returnValue = YES;
        } else if (0x3297 <= hs && hs <= 0x3299) {
            returnValue = YES;
        } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
            returnValue = YES;
        }
    }

    return returnValue;
}



@end

@implementation NSString (FSHash)

#pragma mark - 散列函数
- (NSString *)fs_md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];

    CC_MD5(str, (CC_LONG)strlen(str), buffer);

    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fs_sha1String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];

    CC_SHA1(str, (CC_LONG)strlen(str), buffer);

    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fs_sha256String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];

    CC_SHA256(str, (CC_LONG)strlen(str), buffer);

    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fs_sha512String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];

    CC_SHA512(str, (CC_LONG)strlen(str), buffer);

    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - HMAC 散列函数
- (NSString *)fs_hmacMD5StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];

    CCHmac(kCCHmacAlgMD5, keyData, strlen(keyData), strData, strlen(strData), buffer);

    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fs_hmacSHA1StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];

    CCHmac(kCCHmacAlgSHA1, keyData, strlen(keyData), strData, strlen(strData), buffer);

    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fs_hmacSHA256StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];

    CCHmac(kCCHmacAlgSHA256, keyData, strlen(keyData), strData, strlen(strData), buffer);

    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fs_hmacSHA512StringWithKey:(NSString *)key {
    const char *keyData = key.UTF8String;
    const char *strData = self.UTF8String;
    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];

    CCHmac(kCCHmacAlgSHA512, keyData, strlen(keyData), strData, strlen(strData), buffer);

    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 文件散列函数

#define FileHashDefaultChunkSizeForReadingData 4096

- (NSString *)fs_fileMD5Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }

    CC_MD5_CTX hashCtx;
    CC_MD5_Init(&hashCtx);

    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];

            CC_MD5_Update(&hashCtx, data.bytes, (CC_LONG)data.length);

            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];

    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(buffer, &hashCtx);

    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

- (NSString *)fs_fileSHA1Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }

    CC_SHA1_CTX hashCtx;
    CC_SHA1_Init(&hashCtx);

    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];

            CC_SHA1_Update(&hashCtx, data.bytes, (CC_LONG)data.length);

            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];

    uint8_t buffer[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1_Final(buffer, &hashCtx);

    return [self stringFromBytes:buffer length:CC_SHA1_DIGEST_LENGTH];
}

- (NSString *)fs_fileSHA256Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }

    CC_SHA256_CTX hashCtx;
    CC_SHA256_Init(&hashCtx);

    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];

            CC_SHA256_Update(&hashCtx, data.bytes, (CC_LONG)data.length);

            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];

    uint8_t buffer[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256_Final(buffer, &hashCtx);

    return [self stringFromBytes:buffer length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString *)fs_fileSHA512Hash {
    NSFileHandle *fp = [NSFileHandle fileHandleForReadingAtPath:self];
    if (fp == nil) {
        return nil;
    }

    CC_SHA512_CTX hashCtx;
    CC_SHA512_Init(&hashCtx);

    while (YES) {
        @autoreleasepool {
            NSData *data = [fp readDataOfLength:FileHashDefaultChunkSizeForReadingData];

            CC_SHA512_Update(&hashCtx, data.bytes, (CC_LONG)data.length);

            if (data.length == 0) {
                break;
            }
        }
    }
    [fp closeFile];

    uint8_t buffer[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512_Final(buffer, &hashCtx);

    return [self stringFromBytes:buffer length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 助手方法
/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *strM = [NSMutableString string];

    for (int i = 0; i < length; i++) {
        [strM appendFormat:@"%02x", bytes[i]];
    }

    return [strM copy];
}


@end

@implementation NSString (FSCharacters)

//将汉字转换为拼音
- (instancetype)fs_pinyinOfString{
    NSMutableString * string = [[NSMutableString alloc] initWithString:self];
    //    CFRange range = CFRangeMake(0, 1);
    //&range
    //汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) string,NULL, kCFStringTransformMandarinLatin, NO) ||
            ! CFStringTransform((__bridge CFMutableStringRef) string, NULL, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    return string;//返回转换后带空格的拼音字符串

}

//返回不带空格的字符串
- (instancetype)fs_pinyinWithoutBlankOfString{
    NSMutableString * string = [[NSMutableString alloc] initWithString:self];
    if ( ! CFStringTransform((__bridge CFMutableStringRef) string,NULL, kCFStringTransformMandarinLatin, NO) ||
            ! CFStringTransform((__bridge CFMutableStringRef) string, NULL, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    //返回转换后不带空格的拼音字符串
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}

//汉字转换为拼音后，返回大写的首字母
- (instancetype)fs_firstCharacterOfString{
    NSMutableString * first = [[NSMutableString alloc] initWithString:[self substringWithRange:NSMakeRange(0, 1)]];
    CFRange range = CFRangeMake(0, 1);
    // 汉字转换为拼音,并去除音调
    if ( ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformMandarinLatin, NO) ||
            ! CFStringTransform((__bridge CFMutableStringRef) first, &range, kCFStringTransformStripDiacritics, NO)) {
        return @"";
    }
    NSString * result;
    result = [first substringWithRange:NSMakeRange(0, 1)];
    return result.uppercaseString;
}
@end

@implementation NSString (FSFileSize)

- (unsigned long long)fs_fileSize {

    unsigned long long fileSize = 0;
    // 文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 通过当前路径获取文件或文件夹
    NSError *error = nil;
    NSDictionary *attributes = [fileManager attributesOfItemAtPath:self error:&error];
    if (error || !attributes) {
        NSLog(@"%@",error);
        return 0.0;
    }
    // 判断类型 文件 或 文件夹 或者 其他
    NSString *fileType = attributes.fileType;

    if ([fileType isEqualToString:NSFileTypeDirectory]) {
        // 文件夹
        NSArray <NSString *>*subPaths = [fileManager subpathsAtPath:self];
        // 遍历子路径,累加文件大小
        for (NSString *subPath in subPaths) {
            // 拼接全路径
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            NSError *error = nil;
            NSDictionary *attrs = [fileManager attributesOfItemAtPath:fullPath error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
            fileSize += attrs.fileSize;

        }
    } else if ([fileType isEqualToString:NSFileTypeRegular]) {
        // 文件
        fileSize = attributes.fileSize;
    }
    return fileSize;
}

- (void)fs_logFileSize {

    unsigned long long fileSize = 0;
    // 文件管理者
    NSFileManager *fileManager = [NSFileManager defaultManager];
    // 是否为文件夹
    BOOL isDirectory = NO;
    //  路径是否仔仔
    BOOL isExist = [fileManager fileExistsAtPath:self isDirectory:&isDirectory];

    if (!isExist) {
        return;
    }

    if (isDirectory) {
        // 文件夹
        NSArray <NSString *>*subPaths = [fileManager subpathsAtPath:self];
        // 遍历子路径,累加文件大小
        for (NSString *subPath in subPaths) {
            // 拼接全路径
            NSString *fullPath = [self stringByAppendingPathComponent:subPath];
            NSError *error = nil;
            NSDictionary *attrs = [fileManager attributesOfItemAtPath:fullPath error:&error];
            if (error) {
                NSLog(@"%@",error);
            }
            fileSize += attrs.fileSize;

        }
    } else {
        // 通过当前路径获取文件或文件夹
        NSError *error = nil;
        NSDictionary *attributes = [fileManager attributesOfItemAtPath:self error:&error];
        if (error || !attributes) {
            NSLog(@"%@",error);
            return ;
        }
        // 文件
        fileSize = attributes.fileSize;
    }
    NSLog(@"文件/文件夹大小:%llu B",fileSize);
}

@end

@implementation NSAttributedString (FS)
- (CGFloat)fs_getHeightWithConstrainedWidth:(CGFloat)width {
    CGSize constraintRect = CGSizeMake(width, CGFLOAT_MAX);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return ceil(boundingBox.size.height);
}
- (CGFloat)fs_getWidthWithConstrainedHeight:(CGFloat)height {
    CGSize constraintRect = CGSizeMake(CGFLOAT_MAX, height);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return ceil(boundingBox.size.width);
}
@end


