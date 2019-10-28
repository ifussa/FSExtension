//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIViewController (Extension)
/**
 * 监听通知
 * @param name
 * @param selector
 */
- (void)fs_addNotificationObserverWithName:(NSNotificationName)name selector:(SEL)selector;
/**
 * 移除通知
 */
- (void)fs_addNotificationObserver;
- (CGFloat)getBarHeightWithNavBar:(BOOL)navBar tabBar:(BOOL)tabBar statusBar:(BOOL)statusBar;
@end