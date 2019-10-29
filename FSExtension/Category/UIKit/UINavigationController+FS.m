//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UINavigationController+FS.h"
#import <objc/runtime.h>

@interface JSFullScreenPopGestureRecognizerDelegate : NSObject <UIGestureRecognizerDelegate>
@property (nonatomic, weak) UINavigationController *navigationController;
@end


@implementation JSFullScreenPopGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    // 判断是否是根控制器,如果是,取消手势
    if (self.navigationController.viewControllers.count <= 1) {
        return NO;
    }
    // 如果正在专场动画,取消手势
    if ([[self.navigationController valueForKey:@"_isTransitioning"] boolValue]) {
        return NO;
    }
    // 判断手指移动方向
    CGPoint translation = [gestureRecognizer translationInView:gestureRecognizer.view];
    if (translation.x <= 0) {
        return NO;
    }
    return YES;
}

@end



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


+ (void)load {
    Method originalMethod = class_getInstanceMethod([self class], @selector(pushViewController:animated:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(fs_pushViewController:animated:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}

- (void)fs_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (![self.interactivePopGestureRecognizer.view.gestureRecognizers containsObject:self.fs_popGestureRecognizer]) {
        [self.interactivePopGestureRecognizer.view addGestureRecognizer:self.fs_popGestureRecognizer];
        NSArray *targets = [self.interactivePopGestureRecognizer valueForKey:@"targets"];
        id internalTarget = [targets.firstObject valueForKey:@"target"];
        SEL internalAction = NSSelectorFromString(@"handleNavigationTransition:");
        self.fs_popGestureRecognizer.delegate = [self fs_fullScreenPopGestureRecognizerDelegate];
        [self.fs_popGestureRecognizer addTarget:internalTarget action:internalAction];
        // 禁用系统的交互手势
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    if (![self.viewControllers containsObject:viewController]) {
        [self fs_pushViewController:viewController animated:animated];
    }
}

- (JSFullScreenPopGestureRecognizerDelegate *)fs_fullScreenPopGestureRecognizerDelegate {
    JSFullScreenPopGestureRecognizerDelegate *delegate = objc_getAssociatedObject(self, _cmd);
    if (!delegate) {
        delegate = [[JSFullScreenPopGestureRecognizerDelegate alloc] init];
        delegate.navigationController = self;
        objc_setAssociatedObject(self, _cmd, delegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return delegate;
}

- (UIPanGestureRecognizer *)fs_popGestureRecognizer {
    UIPanGestureRecognizer *panGestureRecognizer = objc_getAssociatedObject(self, _cmd);
    if (panGestureRecognizer == nil) {
        panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
        panGestureRecognizer.maximumNumberOfTouches = 1;
        objc_setAssociatedObject(self, _cmd, panGestureRecognizer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return panGestureRecognizer;
}


@end