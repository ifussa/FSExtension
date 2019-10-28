//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionBlock)();


@interface UINavigationController (Extension)
- (void)fs_popViewControllerWithHandler:(completionBlock)completionHandler;

- (void)fs_popViewControllerWithAnimated:(BOOL)animated handler:(completionBlock)completionHandler;

- (void)fs_pushViewController:(UIViewController *)viewController completion:(completionBlock)completionHandler;

- (void)fs_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(completionBlock)completionHandler;
@end