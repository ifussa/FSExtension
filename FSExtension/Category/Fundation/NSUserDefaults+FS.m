//
//  NSUserDefaults+Extension.m
//  Patient
//
//  Created by Fussa on 16/5/3.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import "NSUserDefaults+FS.h"
#define StandardUserDefaults [NSUserDefaults standardUserDefaults]

@implementation NSUserDefaults (FS)


+ (void)fs_saveBool:(BOOL)value key:(NSString *)key {
    [StandardUserDefaults setBool:value forKey:key];
    [StandardUserDefaults synchronize];
}

+ (BOOL)fs_getBoolForKey:(NSString *)key {
    return [StandardUserDefaults boolForKey:key];
}

+ (void)fs_saveFloat:(float)value key:(NSString *)key {
    [StandardUserDefaults setFloat:value forKey:key];
    [StandardUserDefaults synchronize];
}

+ (float)fs_getFloatForKey:(NSString *)key {
    return [StandardUserDefaults floatForKey:key];
}

+ (void)fs_saveDouble:(double)value key:(NSString *)key {
    [StandardUserDefaults setDouble:value forKey:key];
    [StandardUserDefaults synchronize];
}

+ (double)fs_getDoubleForKey:(NSString *)key {
    return [StandardUserDefaults doubleForKey:key];
}

+ (void)fs_saveInteger:(NSInteger)value key:(NSString *)key {
    [StandardUserDefaults setInteger:value forKey:key];
    [StandardUserDefaults synchronize];
}

+ (NSInteger)fs_getIntegerForKey:(NSString *)key {
    return [StandardUserDefaults integerForKey:key];
}

+ (void)fs_saveURL:(NSURL *)obj key:(NSString *)key {
    [StandardUserDefaults setURL:obj forKey:key];
    [StandardUserDefaults synchronize];
}
+ (NSURL *)fs_getURLForKey:(NSString *)key {
    return [StandardUserDefaults URLForKey:key];
}


+ (void)fs_saveObject:(id)obj key:(NSString *)key {
    [StandardUserDefaults setObject:obj forKey:key];
    [StandardUserDefaults synchronize];
}

+ (id)fs_getObjectForKey:(NSString *)key {
    return [StandardUserDefaults objectForKey:key];
}

+ (void)fs_removeObjectForKey:(NSString *)key {
    [StandardUserDefaults removeObjectForKey:key];
}

@end
