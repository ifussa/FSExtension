//
//  NSUserDefaults+Extension.m
//  Patient
//
//  Created by Fussa on 16/5/3.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import "NSUserDefaults+FS.h"

@implementation NSUserDefaults (FS)


+ (void)fs_saveBool:(BOOL)value key:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:value forKey:key];
    [ud synchronize];
}

+ (float)fs_getBoolForKey:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud boolForKey:key];
}

+ (void)fs_saveFloat:(float)value key:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setFloat:value forKey:key];
    [ud synchronize];
}

+ (float)fs_getFloatForKey:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud floatForKey:key];
}

+ (void)fs_saveInteger:(NSInteger)value key:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setInteger:value forKey:key];
    [ud synchronize];
}

+ (NSInteger)fs_getIntegerForKey:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud integerForKey:key];
}

+ (void)fs_saveObject:(id)obj key:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:obj forKey:key];
    [ud synchronize];
}

+ (id)fs_getObjectForKey:(NSString *)key {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    return [ud objectForKey:key];
}



@end
