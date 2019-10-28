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

@interface UIView (Extension)

@property CGFloat fs_x;
@property CGFloat fs_y;
@property CGFloat fs_centerX;
@property CGFloat fs_centerY;
@property CGFloat fs_width;
@property CGFloat fs_height;
@property CGSize fs_size;

+ (instancetype)footerView;


/**
 *  判断self和view是否重叠
 */
- (BOOL)fs_intersectWithView:(UIView *)view;

+ (instancetype)viewFromeXib;
/**
 * 添加指定位置边框
 * @param color
 * @param width
 * @param type
 */
- (void)fs_addBorderWithColor:(UIColor *)color width:(CGFloat)width type:(FSViewBorderSideType)type;
@end
