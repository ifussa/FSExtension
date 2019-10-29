//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "UIGestureRecognizer+FS.h"
#import <objc/runtime.h>

static const void *FLGestureRecognizerBlockKey = &FLGestureRecognizerBlockKey;
static const void *FLGestureRecognizerDelayKey = &FLGestureRecognizerDelayKey;
static const void *FLGestureRecognizerShouldHandleActionKey = &FLGestureRecognizerShouldHandleActionKey;

@interface UIGestureRecognizer (FSInternal)

@property (nonatomic, setter = fs_setShouldHandleAction:) BOOL fs_shouldHandleAction;

- (void)fs_handleAction:(UIGestureRecognizer *)recognizer;

@end


@implementation UIGestureRecognizer (FS)

+ (instancetype)fs_recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay {
    return [(UIGestureRecognizer *) [[self class] alloc] fs_initWithHandler:block delay:delay];
}

- (instancetype)fs_initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay  {
    self = [self initWithTarget:self action:@selector(fs_handleAction:)];
    if (!self) return nil;

    self.fs_handler = block;
    self.fs_handlerDelay = delay;

    return self;
}

+ (instancetype)fs_recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block
{
    return [self fs_recognizerWithHandler:block delay:0.0];
}

- (instancetype)fs_initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block
{
    return [self fs_initWithHandler:block delay:0.0];
}

- (void)fs_handleAction:(UIGestureRecognizer *)recognizer
{
    void (^handler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) = recognizer.fs_handler;
    if (!handler) return;

    NSTimeInterval delay = self.fs_handlerDelay;
    CGPoint location = [self locationInView:self.view];
    void (^block)(void) = ^{
        if (!self.fs_shouldHandleAction) return;
        handler(self, self.state, location);
    };

    self.fs_shouldHandleAction = YES;

    if (!delay) {
        block();
        return;
    }

    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

- (void)fs_setHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))handler
{
    objc_setAssociatedObject(self, FLGestureRecognizerBlockKey, handler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))fs_handler
{
    return objc_getAssociatedObject(self, FLGestureRecognizerBlockKey);
}

- (void)fs_setHandlerDelay:(NSTimeInterval)delay
{
    NSNumber *delayValue = delay ? @(delay) : nil;
    objc_setAssociatedObject(self, FLGestureRecognizerDelayKey, delayValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)fs_handlerDelay
{
    return [objc_getAssociatedObject(self, FLGestureRecognizerDelayKey) doubleValue];
}

- (void)fs_setShouldHandleAction:(BOOL)flag
{
    objc_setAssociatedObject(self, FLGestureRecognizerShouldHandleActionKey, @(flag), OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (BOOL)fs_shouldHandleAction
{
    return [objc_getAssociatedObject(self, FLGestureRecognizerShouldHandleActionKey) boolValue];
}

- (void)fs_cancel
{
    self.fs_shouldHandleAction = NO;
}

@end

