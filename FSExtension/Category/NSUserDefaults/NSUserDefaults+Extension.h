//
//  NSUserDefaults+Extension.h
//  Patient
//
//  Created by Fussa on 16/5/3.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)


+ (void)saveBool:(BOOL)value key:(NSString *)key;
+ (float)getBoolForKey:(NSString *)key;

+ (void)saveFloat:(float)value key:(NSString *)key;
+ (float)getFloatForKey:(NSString *)key;

+ (void)saveInteger:(NSInteger)value key:(NSString *)key;
+ (NSInteger)getIntegerForKey:(NSString *)key;

+ (void)saveObject:(id)obj key:(NSString *)key;
+ (id)getObjectForKey:(NSString *)key;

@end
