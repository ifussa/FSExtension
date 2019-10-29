//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FSNavigationControllerCompletionBlock)();

@interface UINavigationController (FS)
- (void)fs_popViewControllerWithHandler:(FSNavigationControllerCompletionBlock)completionHandler;

- (void)fs_popViewControllerWithAnimated:(BOOL)animated handler:(FSNavigationControllerCompletionBlock)completionHandler;

- (void)fs_pushViewController:(UIViewController *)viewController completion:(FSNavigationControllerCompletionBlock)completionHandler;

- (void)fs_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(FSNavigationControllerCompletionBlock)completionHandler;


/// 自定义全屏拖拽返回手势
@property (nonatomic, strong, readonly) UIPanGestureRecognizer *fs_popGestureRecognizer;

@end