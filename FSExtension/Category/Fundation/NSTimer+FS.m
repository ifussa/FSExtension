//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "NSTimer+FS.h"

@interface NSTimer (BlocksKitPrivate)

+ (void)fs_executeBlockFromTimer:(NSTimer *)aTimer;
@end

@implementation NSTimer (FS)

+ (id)fs_scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)inRepeats {
    NSParameterAssert(inBlock != nil);
    return [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(fs_executeBlockFromTimer:) userInfo:[inBlock copy] repeats:inRepeats];
}

+ (id)fs_timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)(NSTimer *timer))inBlock repeats:(BOOL)inRepeats {
    NSParameterAssert(inBlock != nil);
    return [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(fs_executeBlockFromTimer:) userInfo:[inBlock copy] repeats:inRepeats];
}

+ (void)fs_executeBlockFromTimer:(NSTimer *)aTimer {
    void (^block)(NSTimer *) = [aTimer userInfo];
    if (block) block(aTimer);
}

@end

