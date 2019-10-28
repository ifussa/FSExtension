//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIScreen (FS)
/**
 * 屏幕的物理高度
 * @return
 */
+ (CGFloat)fs_screenWidth;

/**
 * 屏幕的分辨率
 * @return
 */
+ (CGFloat)fs_screenHeight;

/**
 * 屏幕的分辨率
 * @return
 */
+ (CGFloat)fs_scale;

@end