//
//  UIView+Extension.m
//
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "UIView+FS.h"
#import "UIGestureRecognizer+FS.h"

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
