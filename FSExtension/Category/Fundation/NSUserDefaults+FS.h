//
//  NSUserDefaults+Extension.h
//  Patient
//
//  Created by Fussa on 16/5/3.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (FS)

+ (void)fs_saveBool:(BOOL)value key:(NSString *)key;
+ (BOOL)fs_getBoolForKey:(NSString *)key;

+ (void)fs_saveFloat:(float)value key:(NSString *)key;
+ (float)fs_getFloatForKey:(NSString *)key;

+ (void)fs_saveDouble:(double)value key:(NSString *)key;
+ (double)fs_getDoubleForKey:(NSString *)key;

+ (void)fs_saveInteger:(NSInteger)value key:(NSString *)key;
+ (NSInteger)fs_getIntegerForKey:(NSString *)key;

+ (void)fs_saveURL:(NSURL *)obj key:(NSString *)key;
+ (NSURL *)fs_getURLForKey:(NSString *)key;


+ (void)fs_saveObject:(id)obj key:(NSString *)key;
+ (id)fs_getObjectForKey:(NSString *)key;
+ (void)fs_removeObjectForKey:(NSString *)key;

@end
