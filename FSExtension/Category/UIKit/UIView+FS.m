//
//  UIView+Extension.m
//
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "UIView+FS.h"
#import "UIGestureRecognizer+FS.h"
#import <objc/runtime.h>

@implementation UIView (FS)

#pragma mark - Frame

- (void)setFs_x:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)fs_x {
    return self.frame.origin.x;
}

- (void)setFs_y:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)fs_y {
    return self.frame.origin.y;
}

- (void)setFs_centerX:(CGFloat)centerX {
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)fs_centerX {
    return self.center.x;
}

- (void)setFs_centerY:(CGFloat)centerY {
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)fs_centerY {
    return self.center.y;
}

- (void)setFs_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)fs_width {
    return self.frame.size.width;
}

- (void)setFs_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)fs_height {
    return self.frame.size.height;
}

- (void)setFs_size:(CGSize)size {

    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)fs_size {
    return self.frame.size;
}


- (CGPoint)fs_origin {
    return self.frame.origin;
}

- (void)setFs_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat)fs_top {
    return self.fs_origin.y;
}

- (void)setFs_top:(CGFloat)top {
    CGRect frame = self.frame;
    frame.origin.y = top;
    self.frame = frame;
}
- (CGFloat)fs_left {
    return self.fs_origin.x;
}

- (void)setFs_left:(CGFloat)left {
    CGRect frame = self.frame;
    frame.origin.x = left;
    self.frame = frame;
}

- (CGFloat)fs_right {
    return self.fs_left + self.fs_width;
}

- (void)setFs_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}
- (CGFloat)fs_bottom {
    return self.fs_top + self.fs_height;
}

- (void)setFs_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGSize)fs_boundsSize {
    return self.bounds.size;
}

- (void)setFs_boundsSize:(CGSize)size {
    CGRect bounds = self.bounds;
    bounds.size = size;
    self.bounds = bounds;
}

- (CGFloat)fs_boundsWidth {
    return self.fs_boundsSize.width;
}

- (void)setFs_boundsWidth:(CGFloat)width {
    CGRect bounds = self.bounds;
    bounds.size.width = width;
    self.bounds = bounds;
}

- (CGFloat)fs_boundsHeight {
    return self.fs_boundsSize.height;
}

- (void)setFs_boundsHeight:(CGFloat)height {
    CGRect bounds = self.bounds;
    bounds.size.height = height;
    self.bounds = bounds;
}

- (CGRect)fs_contentBounds {
    return CGRectMake(0.0f, 0.0f, self.fs_boundsWidth, self.fs_boundsHeight);
}

- (CGPoint)fs_contentCenter {
    return CGPointMake(self.fs_boundsWidth/2.0f, self.fs_boundsHeight/2.0f);
}




+ (instancetype)fs_viewFromXib {
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

/**
 *  判断两个View是否重叠
 */
- (BOOL)fs_intersectWithView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;

    CGRect rect1 = [self convertRect:self.bounds toView:nil];
    CGRect rect2 = [view convertRect:view.bounds toView:nil];
    return CGRectIntersectsRect(rect1, rect2);

}

/**
 * 添加指定位置边框
 * @param color
 * @param width
 * @param type
 */
- (void)fs_addBorderWithColor:(UIColor *)color width:(CGFloat)width type:(FSViewBorderSideType)type {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    switch (type) {
        case FSViewBorderSideTypeLeft:
            [bezierPath moveToPoint:CGPointMake(0, self.frame.size.height)];
            [bezierPath addLineToPoint:CGPointZero];
            break;
        case FSViewBorderSideTypeRight:
            [bezierPath moveToPoint:CGPointMake(self.frame.size.width, 0)];
            [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
            break;
        case FSViewBorderSideTypeTop:
            [bezierPath moveToPoint:CGPointZero];
            [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, 0)];
            break;
        case FSViewBorderSideTypeBottom:
            [bezierPath moveToPoint:CGPointMake(0, self.frame.size.height)];
            [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height)];
            break;
        default:
            self.layer.borderWidth = width;
            self.layer.borderColor = color.CGColor;
            break;
    }
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc] init];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [[UIColor clearColor] CGColor];
    shapeLayer.path = bezierPath.CGPath;
    shapeLayer.lineWidth = width;
    [self.layer addSublayer:shapeLayer];
}

- (void)fs_setCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    [self.layer setMasksToBounds:YES];
}


- (void)fs_shakeView {
  [self fs_shakeViewWithFrequency:12.5 rotate:0.1];
}

- (void)fs_shakeViewWithFrequency:(float)frequency rotate:(float)rotate {
    CABasicAnimation *shakeAnimation = [CABasicAnimation animationWithKeyPath:@"transform"];
    shakeAnimation.duration = 1.0 / frequency;
    shakeAnimation.autoreverses = YES;
    shakeAnimation.repeatCount = MAXFLOAT;
    shakeAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, -rotate, 0, 0, 1)];
    shakeAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, rotate, 0, 0, 1)];
    [self.layer addAnimation:shakeAnimation forKey:@"fs_shakeAnimation"];
}

-(void)fs_stopShake {
    [self.layer removeAnimationForKey:@"fs_shakeAnimation"];
}


- (void)fs_pulseViewWithTime:(CGFloat)seconds {
    [UIView animateWithDuration:seconds / 6 animations:^{
        [self setTransform:CGAffineTransformMakeScale(1.1, 1.1)];
    }                completion:^(BOOL finished) {
        if (finished) {
            [UIView animateWithDuration:seconds / 6 animations:^{
                [self setTransform:CGAffineTransformMakeScale(0.96, 0.96)];
            }                completion:^(BOOL finished) {
                if (finished) {
                    [UIView animateWithDuration:seconds / 6 animations:^{
                        [self setTransform:CGAffineTransformMakeScale(1.03, 1.03)];
                    }                completion:^(BOOL finished) {
                        if (finished) {
                            [UIView animateWithDuration:seconds / 6 animations:^{
                                [self setTransform:CGAffineTransformMakeScale(0.985, 0.985)];
                            }                completion:^(BOOL finished) {
                                if (finished) {
                                    [UIView animateWithDuration:seconds / 6 animations:^{
                                        [self setTransform:CGAffineTransformMakeScale(1.007, 1.007)];
                                    }                completion:^(BOOL finished) {
                                        if (finished) {
                                            [UIView animateWithDuration:seconds / 6 animations:^{
                                                [self setTransform:CGAffineTransformMakeScale(1, 1)];
                                            }                completion:^(BOOL finished) {
                                                if (finished) {

                                                }
                                            }];
                                        }
                                    }];
                                }
                            }];
                        }
                    }];
                }
            }];
        }
    }];

}


#pragma mark - Touch

- (void)fs_whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))block {
    if (!block) return;

    UITapGestureRecognizer *gesture = [UITapGestureRecognizer fs_recognizerWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        if (state == UIGestureRecognizerStateRecognized) block();
    }];

    gesture.numberOfTouchesRequired = numberOfTouches;
    gesture.numberOfTapsRequired = numberOfTaps;

    [self.gestureRecognizers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![obj isKindOfClass:[UITapGestureRecognizer class]]) return;

        UITapGestureRecognizer *tap = obj;
        BOOL rightTouches = (tap.numberOfTouchesRequired == numberOfTouches);
        BOOL rightTaps = (tap.numberOfTapsRequired == numberOfTaps);
        if (rightTouches && rightTaps) {
            [gesture requireGestureRecognizerToFail:tap];
        }
    }];

    [self addGestureRecognizer:gesture];
}

- (void)fs_whenTapped:(void (^)(void))block {
    [self fs_whenTouches:1 tapped:1 handler:block];
}

- (void)fs_whenDoubleTapped:(void (^)(void))block {
    [self fs_whenTouches:2 tapped:1 handler:block];
}

- (void)fs_eachSubview:(void (^)(UIView *subview))block {
    NSParameterAssert(block != nil);

    [self.subviews enumerateObjectsUsingBlock:^(UIView *subview, NSUInteger idx, BOOL *stop) {
        block(subview);
    }];
}

@end


static const char *fs_p_singerTapBlockKey;
static const char *fs_p_doubleTapBlockKey;
static const char *fs_p_longPressGestureKey;
static const char *fs_p_pinchGestureKey;
static const char *fs_p_rotationGestureKey;
static const char *fs_p_panGestureKey;
static const char *fs_p_swipeGestureKey;

@implementation UIView (FS_GESTURE)
#pragma mark 单击
- (void)fs_addSingerTapWithBlock:(void (^)(void))tapBlock {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &fs_p_singerTapBlockKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_addSingerTapGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &fs_p_singerTapBlockKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &fs_p_singerTapBlockKey, tapBlock, OBJC_ASSOCIATION_COPY);
}

- (void)p_addSingerTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &fs_p_singerTapBlockKey);
        if (action) {
            action();
        }
    }
}


#pragma mark 双击
- (void)fs_addDoubleTapWithBlock:(void (^)(void))tapBlock {
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &fs_p_doubleTapBlockKey);
    if (!gesture) {
        gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_addDoubleTapGesture:)];
        //需要轻击的次数 默认为2
        gesture.numberOfTapsRequired = 2;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &fs_p_doubleTapBlockKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &fs_p_doubleTapBlockKey, tapBlock, OBJC_ASSOCIATION_COPY);
}

- (void)p_addDoubleTapGesture:(UITapGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateRecognized) {
        void(^action)(void) = objc_getAssociatedObject(self, &fs_p_doubleTapBlockKey);
        if (action) {
            action();
        }
    }
}

#pragma mark 长按
- (void)fs_addLongPressGestureWithMinimumPressDuration:(NSTimeInterval)duration allowableMovement:(CGFloat)movement stateBegin:(void (^)(void))stateBeginBlock stateEnd:(void (^)(void))stateEndBlock {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = objc_getAssociatedObject(self, &fs_p_longPressGestureKey);
    if (!longPress) {
        longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(p_addLongePressGesture:)];
        // 触发时间
        longPress.minimumPressDuration = duration;
        // 允许长按时间触发前允许手指滑动的范围，默认是10
        longPress.allowableMovement = movement;
        [self addGestureRecognizer:longPress];
        objc_setAssociatedObject(self, &fs_p_longPressGestureKey, longPress, OBJC_ASSOCIATION_RETAIN);
    }

    void(^longPressStateBlock)(UIGestureRecognizerState state) = ^(UIGestureRecognizerState state) {
        switch (state) {
            case UIGestureRecognizerStateBegan:
                if (stateBeginBlock) {
                    stateBeginBlock();
                }
                break;
            case UIGestureRecognizerStateEnded:
                if (stateEndBlock) {
                    stateEndBlock();
                }
                break;
            default:
                break;
        }
    };
    objc_setAssociatedObject(self, &fs_p_longPressGestureKey, longPressStateBlock, OBJC_ASSOCIATION_COPY);
}

- (void)fs_addLongPressGestureWithMinimumPressDuration:(NSTimeInterval)duration stateBegin:(void (^)(void))stateBeginBlock stateEnd:(void (^)(void))stateEndBlock {
    [self fs_addLongPressGestureWithMinimumPressDuration:duration allowableMovement:10 stateBegin:stateBeginBlock stateEnd:stateEndBlock];
}

- (void)p_addLongePressGesture:(UILongPressGestureRecognizer *)gesture {
    void(^action)(UIGestureRecognizerState state) = objc_getAssociatedObject(self, &fs_p_longPressGestureKey);
    if (action) {
        action(gesture.state);
    }
}

#pragma mark 捏合手势
- (void)fs_addPinchGestureWithBlock:(void (^)(CGFloat, CGFloat, UIGestureRecognizerState))block {
    self.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *gesture = objc_getAssociatedObject(self, &fs_p_pinchGestureKey);
    if (!gesture) {
        gesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(p_addPinchGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &fs_p_pinchGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &fs_p_pinchGestureKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)p_addPinchGesture:(UIPinchGestureRecognizer *)gesture {
    void(^action)(CGFloat scale, CGFloat velocity, UIGestureRecognizerState state) = objc_getAssociatedObject(self, &fs_p_pinchGestureKey);
    if (action) {
        action(gesture.scale, gesture.velocity, gesture.state);
    }
}

#pragma mark 旋转手势
- (void)fs_addRotationGestureWithBlock:(void (^)(CGFloat, CGFloat, UIGestureRecognizerState))block {
    self.userInteractionEnabled = YES;
    UIRotationGestureRecognizer *gesture = objc_getAssociatedObject(self, &fs_p_rotationGestureKey);
    if (!gesture) {
        gesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(p_addRotationGesture:)];
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &fs_p_rotationGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &fs_p_rotationGestureKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)p_addRotationGesture:(UIRotationGestureRecognizer *)gesture {
    void(^action)(CGFloat rotation, CGFloat velocity, UIGestureRecognizerState state) = objc_getAssociatedObject(self, &fs_p_rotationGestureKey);
    if (action) {
        action(gesture.rotation, gesture.velocity, gesture.state);
    }
}

#pragma mark 移动
- (void)fs_addPanGestureWithMinimumNumberOfTouches:(NSUInteger)min maximumNumberOfTouches:(NSUInteger)max block:(void (^)(CGPoint, UIGestureRecognizerState, UIPanGestureRecognizer *))block {
    self.userInteractionEnabled = YES;
    UIPanGestureRecognizer *gesture = objc_getAssociatedObject(self, &fs_p_panGestureKey);
    if (!gesture) {
        gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(p_addPanGesture:)];
        gesture.minimumNumberOfTouches = min;
        gesture.maximumNumberOfTouches = max;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &fs_p_panGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &fs_p_panGestureKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)fs_addPanGestureWithBlock:(void (^)(CGPoint, UIGestureRecognizerState, UIPanGestureRecognizer *))block {
    [self fs_addPanGestureWithMinimumNumberOfTouches:1 maximumNumberOfTouches:UINT_MAX block:block];
}

- (void)p_addPanGesture:(UIPanGestureRecognizer *)gesture {
    void(^action)(CGPoint point, UIGestureRecognizerState state, UIPanGestureRecognizer *gesture) = objc_getAssociatedObject(self, &fs_p_panGestureKey);
    if (action) {
        CGPoint point = [gesture translationInView:self];
        action(point, gesture.state, gesture);
    }
}

#pragma mark 轻扫
- (void)fs_addSwipeGestureWithDirection:(UISwipeGestureRecognizerDirection)direction numberOfTouchesRequired:(NSUInteger)numberOfTouches block:(void (^)(UIGestureRecognizerState))block {
    self.userInteractionEnabled = YES;
    UISwipeGestureRecognizer *gesture = objc_getAssociatedObject(self, &fs_p_swipeGestureKey);
    if (!gesture) {
        gesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(p_addSwipeGesture:)];
        gesture.direction = direction;
        gesture.numberOfTouchesRequired = numberOfTouches;
        [self addGestureRecognizer:gesture];
        objc_setAssociatedObject(self, &fs_p_swipeGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
    }
    objc_setAssociatedObject(self, &fs_p_swipeGestureKey, block, OBJC_ASSOCIATION_COPY);
}

- (void)fs_addSwipeGestureWithDirection:(UISwipeGestureRecognizerDirection)direction block:(void (^)(UIGestureRecognizerState))block {
    [self fs_addSwipeGestureWithDirection:direction numberOfTouchesRequired:1 block:block];
}

- (void)p_addSwipeGesture:(UISwipeGestureRecognizer *)gesture {
    void(^action)(UIGestureRecognizerState state) = objc_getAssociatedObject(self, &fs_p_swipeGestureKey);
    if (action) {
        action(gesture.state);
    }
}

@end
