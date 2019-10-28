//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UIScreen+FS.h"


@implementation UIScreen (FS)
/**
 * 屏幕的物理高度
 * @return
 */
+ (CGFloat)fs_screenWidth {
    return self.mainScreen.bounds.size.width;
}

/**
 * 屏幕的分辨率
 * @return
 */
+ (CGFloat)fs_screenHeight {
    return self.mainScreen.bounds.size.height;
}

/**
 * 屏幕的分辨率
 * @return
 */
+ (CGFloat)fs_scale {
    return self.mainScreen.scale;
}

@end