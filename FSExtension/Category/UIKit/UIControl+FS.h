//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIControl (FS)
/**
 *将块添加给某一特定事件
 */
- (void)fs_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;

/**
 *移除特定事件组合的所有数据块.
 */
- (void)fs_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents;

/**
 *检查控件是否具有任何特定的事件块.
 */
- (BOOL)fs_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents;

@end