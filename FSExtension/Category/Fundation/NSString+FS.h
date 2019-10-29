//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FS)
/**
 * 获取字符串的高度
 * @param width 最大宽度
 * @return 高度
 */
-(CGFloat)fs_getHeightWithConstrainedWidth:(CGFloat)width font:(UIFont *)font;
/**
 * 获取字符串的宽度
 * @param height 最大高度
 * @return 宽度
 */
-(CGFloat)fs_getWidthWithConstrainedHeight:(CGFloat)height font:(UIFont *)font;


#pragma mark - 校验
- (BOOL)fs_empty;
- (BOOL)fs_eq:(NSString *)other;
- (BOOL)fs_isValueOf:(NSArray *)array;
- (BOOL)fs_isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;
- (BOOL)fs_isNumber;
- (BOOL)fs_isEmail;
- (BOOL)fs_isUrl;
- (BOOL)fs_isIPAddress;
- (NSString *)fs_substringFromIndex:(NSUInteger)from untilString:(NSString *)string;


#pragma mark - Emoji
/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)fs_emojiWithIntCode:(long)intCode;

/**
 *  将十六进制的编码转为emoji字符
 */
+ (NSString *)fs_emojiWithStringCode:(NSString *)stringCode;

/**
 * 转换为emoji
 */
- (NSString *)fs_emoji;

/**
 *  是否为emoji字符
 */
- (BOOL)fs_isEmoji;


@end

@interface NSString (FSHash)

#pragma mark - 散列函数
/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)fs_md5String;

/**
 *  计算SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)fs_sha1String;

/**
 *  计算SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)fs_sha256String;

/**
 *  计算SHA 512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512
 *  @endcode
 *
 *  @return 128个字符的SHA 512散列字符串
 */
- (NSString *)fs_sha512String;

#pragma mark - HMAC 散列函数
/**
 *  计算HMAC MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl dgst -md5 -hmac "key"
 *  @endcode
 *
 *  @return 32个字符的HMAC MD5散列字符串
 */
- (NSString *)fs_hmacMD5StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha1 -hmac "key"
 *  @endcode
 *
 *  @return 40个字符的HMAC SHA1散列字符串
 */
- (NSString *)fs_hmacSHA1StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha256 -hmac "key"
 *  @endcode
 *
 *  @return 64个字符的HMAC SHA256散列字符串
 */
- (NSString *)fs_hmacSHA256StringWithKey:(NSString *)key;

/**
 *  计算HMAC SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  echo -n "string" | openssl sha -sha512 -hmac "key"
 *  @endcode
 *
 *  @return 128个字符的HMAC SHA512散列字符串
 */
- (NSString *)fs_hmacSHA512StringWithKey:(NSString *)key;

#pragma mark - 文件散列函数

/**
 *  计算文件的MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 file.dat
 *  @endcode
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *)fs_fileMD5Hash;

/**
 *  计算文件的SHA1散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha1 file.dat
 *  @endcode
 *
 *  @return 40个字符的SHA1散列字符串
 */
- (NSString *)fs_fileSHA1Hash;

/**
 *  计算文件的SHA256散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha256 file.dat
 *  @endcode
 *
 *  @return 64个字符的SHA256散列字符串
 */
- (NSString *)fs_fileSHA256Hash;

/**
 *  计算文件的SHA512散列结果
 *
 *  终端测试命令：
 *  @code
 *  openssl sha -sha512 file.dat
 *  @endcode
 *
 *  @return 128个字符的SHA512散列字符串
 */
- (NSString *)fs_fileSHA512Hash;

@end

@interface NSString (FSCharacters)

/**
 *  将汉字转换为拼音(无音标)
 */
- (instancetype)fs_pinyinOfString;

/**
 *  返回不带空格的拼音(无音标)
 */
- (instancetype)fs_pinyinWithoutBlankOfString;

/**
 *  汉字转换为拼音后，返回大写的首字母
 */
- (instancetype)fs_firstCharacterOfString;

@end

@interface NSString (FSFileSize)

/**
 * 返回文件或文件夹的大小,单位B
 */
- (unsigned long long)fs_fileSize;

/**
 * 控制台打印文件或文件夹大小
 */
- (void)fs_logFileSize;

@end

@interface NSAttributedString (FS)
/**
 * 获取字符串的高度
 * @param width 最大宽度
 * @return 高度
 */
-(CGFloat)fs_getHeightWithConstrainedWidth:(CGFloat)width;
/**
 * 获取字符串的宽度
 * @param height 最大高度
 * @return 宽度
 */
-(CGFloat)fs_getWidthWithConstrainedHeight:(CGFloat)height;

@end
