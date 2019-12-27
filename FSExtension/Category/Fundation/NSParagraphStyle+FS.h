//
//  NSParagraphStyle+FS.h
//  FSExtensionDemo
//
// Created by 曾福生 on 2019/12/28.
// Copyright (c) 2019 Fussa. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface NSParagraphStyle (FS)

/// 从 CTParagraphStyleRef 转换成的 NSParagraphStyle
/// @param CTStyle CoreText 段落样式
+ (nullable NSParagraphStyle *)fs_styleWithCTStyle:(CTParagraphStyleRef)CTStyle;


/// 转换成 CoreText 样式
- (nullable CTParagraphStyleRef)fs_CTStyle CF_RETURNS_RETAINED;


@end