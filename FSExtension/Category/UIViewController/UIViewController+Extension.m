//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UIViewController+Extension.h"


@implementation UIViewController (Extension)
/**
 * 监听通知
 * @param name
 * @param selector
 */
- (void)fs_addNotificationObserverWithName:(NSNotificationName)name selector:(SEL)selector {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:name object:nil];
}

/**
 * 移除通知
 */
- (void)fs_addNotificationObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (CGFloat)getBarHeightWithNavBar:(BOOL)navBar tabBar:(BOOL)tabBar statusBar:(BOOL)statusBar {
    CGFloat height = 0;
    height += navBar ? self.navigationController.navigationBar.frame.size.height : 0;
    height += tabBar ? self.tabBarController.tabBar.frame.size.height : 0;
    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
    height += navBar ? statusBarFrame.size.height : 0;
    return height;
}

@end