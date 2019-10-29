//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UIColor+FS.h"


@implementation UIColor (FS)
+ (instancetype)fs_randomColor {
    return [self fs_randomColorWithAlpha:1];
}

+ (instancetype)fs_randomColorWithAlpha:(CGFloat)alpha {
    CGFloat resultAlpha = alpha;
    if (alpha < 0) {
        resultAlpha = 0;
    } else if (alpha > 1) {
        resultAlpha = 1;
    }
    uint32_t r = arc4random_uniform(255);
    uint32_t g = arc4random_uniform(255);
    uint32_t b = arc4random_uniform(255);
    return [[UIColor alloc] initWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:resultAlpha];
}


+ (UIColor *)fs_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha {
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6) {
        return [UIColor clearColor];
    }

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}

//默认alpha值为1
+ (UIColor *)fs_colorWithHexString:(NSString *)color {
    return [self fs_colorWithHexString:color alpha:1.0f];
}

+ (id)fs_colorWithHex:(unsigned int)hex {
    return [UIColor fs_colorWithHex:hex alpha:1.0];
}

+ (id)fs_colorWithHex:(unsigned int)hex alpha:(float)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16)) / 255.0 green:((float)((hex & 0xFF00) >> 8)) / 255.0 blue:((float)(hex & 0xFF)) / 255.0 alpha:alpha];
}

- (NSUInteger)fs_rgbaValue {
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a]) {
        NSUInteger rr = (NSUInteger)(r * 255 + 0.5);
        NSUInteger gg = (NSUInteger)(g * 255 + 0.5);
        NSUInteger bb = (NSUInteger)(b * 255 + 0.5);
        NSUInteger aa = (NSUInteger)(a * 255 + 0.5);

        return (rr << 24) | (gg << 16) | (bb << 8) | aa;
    } else {
        return 0;
    }
}

@end