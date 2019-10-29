//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIWindow (FS)


+(UIWindow *)fs_keyWindow;

/**
 *屏幕截图
 */
- (UIImage *)fs_takeScreenshot;

@end