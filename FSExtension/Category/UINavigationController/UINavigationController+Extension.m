//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UINavigationController+Extension.h"


@implementation UINavigationController (Extension)

- (void)fs_popViewControllerWithHandler:(completionBlock)completionHandler {
    [self fs_popViewControllerWithAnimated:YES handler:completionHandler];
}

- (void)fs_popViewControllerWithAnimated:(BOOL)animated handler:(completionBlock)completionHandler {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completionHandler];
    [self popViewControllerAnimated:animated];
    [CATransaction commit];
}

- (void)fs_pushViewController:(UIViewController *)viewController completion:(completionBlock)completionHandler {
    [self fs_pushViewController:viewController animated:YES completion:completionHandler];
}

- (void)fs_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(completionBlock)completionHandler {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completionHandler];
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}

@end