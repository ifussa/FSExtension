//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "UIControl+FS.h"
#import <objc/runtime.h>

static const void *FSControlHandlersKey = &FSControlHandlersKey;

#pragma mark Private

@interface FLControlWrapper : NSObject <NSCopying>

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents;
@property (nonatomic) UIControlEvents controlEvents;
@property (nonatomic, copy) void (^handler)(id sender);
@end

@implementation FLControlWrapper

- (id)initWithHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents {
    self = [super init];
    if (!self) return nil;

    self.handler = handler;
    self.controlEvents = controlEvents;

    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [[FLControlWrapper alloc] initWithHandler:self.handler forControlEvents:self.controlEvents];
}

- (void)invoke:(id)sender {
    self.handler(sender);
}


@end

#pragma mark Category

@implementation UIControl (FS)

- (void)fs_addEventHandler:(void (^)(id sender))handler forControlEvents:(UIControlEvents)controlEvents
{
    NSParameterAssert(handler);

    NSMutableDictionary *events = objc_getAssociatedObject(self, FSControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, FSControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    NSNumber *key = @(controlEvents);
    NSMutableSet *handlers = events[key];
    if (!handlers) {
        handlers = [NSMutableSet set];
        events[key] = handlers;
    }

    FLControlWrapper *target = [[FLControlWrapper alloc] initWithHandler:handler forControlEvents:controlEvents];
    [handlers addObject:target];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
}

- (void)fs_removeEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self, FSControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, FSControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];

    if (!handlers)
        return;

    [handlers enumerateObjectsUsingBlock:^(id sender, BOOL *stop) {
        [self removeTarget:sender action:NULL forControlEvents:controlEvents];
    }];

    [events removeObjectForKey:key];
}

- (BOOL)fs_hasEventHandlersForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableDictionary *events = objc_getAssociatedObject(self, FSControlHandlersKey);
    if (!events) {
        events = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, FSControlHandlersKey, events, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    NSNumber *key = @(controlEvents);
    NSSet *handlers = events[key];

    if (!handlers)
        return NO;

    return !!handlers.count;
}


@end

