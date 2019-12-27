//
//  UIFont+FS.h
//  FSExtensionDemo
//
// Created by 曾福生 on 2019/12/28.
// Copyright (c) 2019 Fussa. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIFont (FS)

@end

@interface UIFont (FS_BASE_FONT)

+ (UIFont *)fs_fontWithName:(NSString *)name size:(CGFloat)size;

+ (UIFont *)fs_pingFangSCRegular:(CGFloat)size;

+ (UIFont *)fs_pingFangSCMedium:(CGFloat)size;

+ (UIFont *)fs_pingFangSCSemibold:(CGFloat)size;

@end