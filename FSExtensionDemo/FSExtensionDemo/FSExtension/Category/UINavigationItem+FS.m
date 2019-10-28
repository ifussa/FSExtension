//
// Created by Fussa on 2018/5/26.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UINavigationItem+FS.h"
#import <objc/runtime.h>
#import "NSObject+FS.h"
@implementation UINavigationItem (FS)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{

        if (@available(iOS 11.0, *)) {
            // ios 11 下无效
        } else {
            Method originalMethodImp = class_getInstanceMethod(self, @selector(backBarButtonItem));
            Method destMethodImp = class_getInstanceMethod(self, @selector(myCustomBackButton_backBarbuttonItem));
            method_exchangeImplementations(originalMethodImp, destMethodImp);
        }

    });
}

static char kCustomBackButtonKey;

- (UIBarButtonItem *)myCustomBackButton_backBarbuttonItem {
    // 先get原本的backBarButtonItem，存在则直接返回， 没有的话再返回默认按钮
    UIBarButtonItem *item = [self myCustomBackButton_backBarbuttonItem];
    if (item) {
        return item;
    }
    item = objc_getAssociatedObject(self, &kCustomBackButtonKey);
    if (!item) {
        item = [[self class] fs_customGlobalBackBarButtonItem];
        objc_setAssociatedObject(self, &kCustomBackButtonKey, item, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return item;
}

+ (UIBarButtonItem *)fs_customGlobalBackBarButtonItem {
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:NULL];
    return item;
}


- (void)dealloc {
    objc_removeAssociatedObjects(self);
}

@end