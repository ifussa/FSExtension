//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FS)
/**
 * 创建随机颜色
 */
+ (instancetype)fs_randomColor;

/**
 * 创建随机颜色
 */
+ (instancetype)fs_randomColorWithAlpha:(CGFloat)alpha;

/**
 * 通过 16进制字符串 创建颜色
 */
+ (UIColor *)fs_colorWithHexString:(NSString *)color;

/**
 *  通过 16进制字符串 与 透明度 创建颜色
 */
+ (UIColor *)fs_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

/**
 *  通过 16进制无符号整型 创建颜色
 */

+ (UIColor *)fs_colorWithHex:(unsigned int)hex;

/**
 *  通过 16进制无符号整型 与 透明度 创建颜色
 */
+ (UIColor *)fs_colorWithHex:(unsigned int)hex alpha:(float)alpha;

/**
 * 颜色的RGB值
 */
- (NSUInteger)fs_rgbaValue;
@end