//
//  WJExtensionConfig.m
//  Patient
//
//  Created by Fussa on 16/5/4.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import "WJExtensionConfig.h"
#import <MJExtension/MJExtension.h>

@implementation WJExtensionConfig
/**
 * 这个方法会在MJExtensionConfig加载进内存时调用一次
 */
+ (void)load {

#pragma mark 如果使用NSObject来调用这些方法, 代表所有继承自NSObject的类都会生效
#pragma mark NSObject中的ID属性对应着字典中的id
    /**
     * 处理全局中的ID属性对应着字典中的id
     */
    [NSObject mj_setupReplacedKeyFromPropertyName:^NSDictionary * {
        return @{
                @"ID": @"id",
        };
    }];

    /**
     * 处理空字符串
     */
    [NSObject mj_setupNewValueFromOldValue:^id(id object, id oldValue, MJProperty *property) {
        if (oldValue == nil || [oldValue isKindOfClass:[NSNull class]]) {
            return @"";
        }
        return oldValue;
    }];

    /**
     * 所有驼峰属性转成下划线key去字典中取值
     */
//    [NSObject mj_setupReplacedKeyFromPropertyName121:^id(NSString *propertyName) {
//        return [propertyName mj_underlineFromCamel];
//    }];
}
@end
