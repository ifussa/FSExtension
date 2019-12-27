//
//  UIViewController+FS.m
//  FSExtensionDemo
//
// Created by 曾福生 on 2019/12/28.
// Copyright (c) 2019 Fussa. All rights reserved.
//
#import "UIViewController+FS.h"
#import <objc/runtime.h>

@implementation UIViewController (FS)
@end


static const char *fs_automaticallySetModalPresentationStyleKey;

@implementation UIViewController (FS_ChangeDefaultPresentStyle)


+ (void)load {
    Method originAddObserverMethod = class_getInstanceMethod(self, @selector(presentViewController:animated:completion:));
    Method swizzledAddObserverMethod = class_getInstanceMethod(self, @selector(fs_presentViewController:animated:completion:));
    method_exchangeImplementations(originAddObserverMethod, swizzledAddObserverMethod);
}

- (void)setMtfy_automaticallySetModalPresentationStyle:(BOOL)fs_automaticallySetModalPresentationStyle {
    objc_setAssociatedObject(self, fs_automaticallySetModalPresentationStyleKey, @(fs_automaticallySetModalPresentationStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)fs_automaticallySetModalPresentationStyle {
    id obj = objc_getAssociatedObject(self, fs_automaticallySetModalPresentationStyleKey);
    if (obj) {
        return [obj boolValue];
    }
    return [self.class fs_automaticallySetModalPresentationStyle];
}

+ (BOOL)fs_automaticallySetModalPresentationStyle {
    if ([self isKindOfClass:[UIImagePickerController class]] || [self isKindOfClass:[UIAlertController class]]) {
        return NO;
    }
    return YES;
}

- (void)fs_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    if (@available(iOS 13.0, *)) {
        if (viewControllerToPresent.fs_automaticallySetModalPresentationStyle) {
            viewControllerToPresent.modalPresentationStyle = UIModalPresentationFullScreen;
        }
        [self fs_presentViewController:viewControllerToPresent animated:flag completion:completion];
    } else {
        [self fs_presentViewController:viewControllerToPresent animated:flag completion:completion];
    }
}


@end

