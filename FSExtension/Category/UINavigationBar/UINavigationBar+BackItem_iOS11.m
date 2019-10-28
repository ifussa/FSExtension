//
// Created by Fussa on 2018/5/26.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UINavigationBar+BackItem_iOS11.h"
#import "UINavigationItem+BackItem.h"
#import <objc/runtime.h>

@implementation UINavigationBar (BackItem_iOS11)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       Method originalMethodImp = class_getInstanceMethod(self, @selector(pushNavigationItem:animated:));
        Method destMethodImp = class_getInstanceMethod(self, @selector(iOS11CustomPushNavigationItem:animated:));
        method_exchangeImplementations(originalMethodImp, destMethodImp);
    });
}

-(void)iOS11CustomPushNavigationItem:(UINavigationItem *)item animated:(BOOL)animated {
    if (!self.topItem.backBarButtonItem) {
        UIBarButtonItem *barButtonItem = [UINavigationItem customGlobalBackBarButtonItem];
        [self.topItem setBackBarButtonItem:barButtonItem];
    }
    [self iOS11CustomPushNavigationItem:item animated:animated];
}

@end