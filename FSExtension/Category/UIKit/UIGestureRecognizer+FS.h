//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

/**
 使用示例:
 UITapGestureRecognizer *singleTap = [UITapGestureRecognizer recognizerWithHandler:^(id sender) {
      NSLog(@"Single tap.");
 }  delay:0.18];
 [self addGestureRecognizer:singleTap];

 UITapGestureRecognizer *doubleTap = [UITapGestureRecognizer recognizerWithHandler:^(id sender) {
 [singleTap cancel];
     NSLog(@"Double tap.");
 }];
 doubleTap.numberOfTapsRequired = 2;
 [self addGestureRecognizer:doubleTap];

*/

#import <UIKit/UIKit.h>

@interface UIGestureRecognizer (FS)

- (instancetype)fs_initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay NS_REPLACES_RECEIVER;

+ (instancetype)fs_recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block delay:(NSTimeInterval)delay;

- (instancetype)fs_initWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

+ (instancetype)fs_recognizerWithHandler:(void (^)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location))block;

@property (nonatomic, copy, setter = fs_setHandler:) void (^fs_handler)(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location);
@property (nonatomic, setter = fs_setHandlerDelay:) NSTimeInterval fs_handlerDelay;

@end
