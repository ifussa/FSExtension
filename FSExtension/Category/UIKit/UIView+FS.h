//
//  UIView+Extension.h
//
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * 边框类型
 */
typedef NS_ENUM(NSInteger, FSViewBorderSideType) {
    FSViewBorderSideTypeAll = 0,
    FSViewBorderSideTypeTop = 1,
    FSViewBorderSideTypeBottom = 2,
    FSViewBorderSideTypeLeft = 3,
    FSViewBorderSideTypeRight = 4
};

@interface UIView (FS)

#pragma mark - Frame
@property (nonatomic, assign) CGFloat fs_x;
@property (nonatomic, assign) CGFloat fs_y;
@property (nonatomic, assign) CGFloat fs_centerX;
@property (nonatomic, assign) CGFloat fs_centerY;
@property (nonatomic, assign) CGFloat fs_width;
@property (nonatomic, assign) CGFloat fs_height;
@property (nonatomic, assign) CGSize fs_size;

@property (nonatomic, assign) CGPoint fs_origin;
@property (nonatomic, assign) CGFloat fs_top;
@property (nonatomic, assign) CGFloat fs_left;
@property (nonatomic, assign) CGFloat fs_bottom;
@property (nonatomic, assign) CGFloat fs_right;
@property (nonatomic, assign) CGSize fs_boundsSize;
@property (nonatomic, assign) CGFloat fs_boundsWidth;
@property (nonatomic, assign) CGFloat fs_boundsHeight;
@property (nonatomic, readonly) CGRect fs_contentBounds;
@property (nonatomic, readonly) CGPoint fs_contentCenter;



/**
 * 从xib加载View
 */
+ (instancetype)fs_viewFromXib;

/**
 *  判断self和view是否重叠
 */
- (BOOL)fs_intersectWithView:(UIView *)view;

/**
 * 添加指定位置边框
 */
- (void)fs_addBorderWithColor:(UIColor *)color width:(CGFloat)width type:(FSViewBorderSideType)type;

/**
 * 设置圆角
 */
- (void)fs_setCornerRadius:(CGFloat)radius;


#pragma mark - Animate
/**
 *视图抖动
 */
- (void)fs_shakeView;

/**
 * 视图抖动
 * @param frequency 频率
 * @param rotate 抖动角度
 */
- (void)fs_shakeViewWithFrequency:(float)frequency rotate:(float)rotate;

/**
 *移除视图抖动
 */
-(void)fs_stopShake;


/**
 *脉冲效果
 *@param seconds 脉冲持续时间(秒)
 */
- (void)fs_pulseViewWithTime:(CGFloat)seconds;


#pragma mark - Touch

/**
 *增加识别手指敲击的手势
 *@param numberOfTouches 手指tap次数
 *@param numberOfTaps 手指数.
 */
- (void)fs_whenTouches:(NSUInteger)numberOfTouches tapped:(NSUInteger)numberOfTaps handler:(void (^)(void))block;

/**
 *增加识别一个手指敲击一次的手势
 */
- (void)fs_whenTapped:(void (^)(void))block;

/**
 *增加识别一个手指敲击两次的手势.
 */
- (void)fs_whenDoubleTapped:(void (^)(void))block;

/**
 *非递归的子视图遍历
 */
- (void)fs_eachSubview:(void (^)(UIView *subview))block;



@end
