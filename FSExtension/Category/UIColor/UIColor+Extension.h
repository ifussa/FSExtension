//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

#define RGBA_COLOR(R, G, B, A) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:A]
#define RGB_COLOR(R, G, B) [UIColor colorWithRed:((R) / 255.0f) green:((G) / 255.0f) blue:((B) / 255.0f) alpha:1.0f]


@interface UIColor (Extension)
/**
 * 随机生成颜色
 * @return UIColor
 */
+ (instancetype)fs_randomColor;
+ (instancetype)fs_randomColorWithAlpha:(CGFloat)alpha;
+ (UIColor *)fs_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
+ (UIColor *)fs_colorWithHexString:(NSString *)color;
@end