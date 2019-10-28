//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UINavigationController+FS.h"


@implementation UINavigationController (FS)

- (void)fs_popViewControllerWithHandler:(FSNavigationControllerCompletionBlock)completionHandler {
    [self fs_popViewControllerWithAnimated:YES handler:completionHandler];
}

- (void)fs_popViewControllerWithAnimated:(BOOL)animated handler:(FSNavigationControllerCompletionBlock)completionHandler {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completionHandler];
    [self popViewControllerAnimated:animated];
    [CATransaction commit];
}

- (void)fs_pushViewController:(UIViewController *)viewController completion:(FSNavigationControllerCompletionBlock)completionHandler {
    [self fs_pushViewController:viewController animated:YES completion:completionHandler];
}

- (void)fs_pushViewController:(UIViewController *)viewController animated:(BOOL)animated completion:(FSNavigationControllerCompletionBlock)completionHandler {
    [CATransaction begin];
    [CATransaction setCompletionBlock:completionHandler];
    [self pushViewController:viewController animated:animated];
    [CATransaction commit];
}

@end