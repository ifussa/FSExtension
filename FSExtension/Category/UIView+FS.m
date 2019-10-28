//
//  UIView+Extension.m
//
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "UIView+FS.h"


@implementation UIView (FS)

- (void)setFs_x:(CGFloat)fs_x {
    CGRect frame = self.frame;
    frame.origin.x = fs_x;
    self.frame = frame;
}

- (CGFloat)fs_x {
    return self.frame.origin.x;
}

- (void)setFs_y:(CGFloat)fs_y {
    CGRect frame = self.frame;
    frame.origin.y = fs_y;
    self.frame = frame;
}

- (CGFloat)fs_y {
    return self.frame.origin.y;
}

- (void)setFs_centerX:(CGFloat)fs_centerX {
    CGPoint center = self.center;
    center.x = fs_centerX;
    self.center = center;
}

- (CGFloat)fs_centerX {
    return self.center.x;
}

- (void)setFs_centerY:(CGFloat)fs_centerY {
    CGPoint center = self.center;
    center.y = fs_centerY;
    self.center = center;
}

- (CGFloat)fs_centerY {
    return self.center.y;
}

- (void)setFs_width:(CGFloat)fs_width {
    CGRect frame = self.frame;
    frame.size.width = fs_width;
    self.frame = frame;
}

- (CGFloat)fs_width {
    return self.frame.size.width;
}

- (void)setFs_height:(CGFloat)fs_height {
    CGRect frame = self.frame;
    frame.size.height = fs_height;
    self.frame = frame;
}

- (CGFloat)fs_height {
    return self.frame.size.height;
}

- (void)setFs_size:(CGSize)fs_size {

    CGRect frame = self.frame;
    frame.size = fs_size;
    self.frame = frame;
}

- (CGSize)fs_size {
    return self.frame.size;
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

@end
