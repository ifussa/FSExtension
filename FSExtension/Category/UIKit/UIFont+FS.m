//
//  UIFont+FS.m
//  FSExtensionDemo
//
// Created by 曾福生 on 2019/12/28.
// Copyright (c) 2019 Fussa. All rights reserved.
//
#import "UIFont+FS.h"


@implementation UIFont (FS)
@end

@implementation UIFont (FS_BASE_FONT)


+ (UIFont *)fs_fontWithName:(NSString *)name size:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:name size:size];
    if (!font) {
        font = [UIFont systemFontOfSize:size];
    }
    return font;
}

+ (UIFont *)fs_pingFangSCRegular:(CGFloat)size {
    return [UIFont fs_fontWithName:@"PingFangSC-Regular" size:size];
}

+ (UIFont *)fs_pingFangSCMedium:(CGFloat)size {
    return [UIFont fs_fontWithName:@"PingFangSC-Medium" size:size];
}

+ (UIFont *)fs_pingFangSCSemibold:(CGFloat)size {
    return [UIFont fs_fontWithName:@"PingFangSC-Semibold" size:size];
}

@end