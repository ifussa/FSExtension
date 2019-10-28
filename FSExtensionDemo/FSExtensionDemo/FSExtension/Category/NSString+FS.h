//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (FS)
/**
 * 获取字符串的高度
 * @param width 最大宽度
 * @return 高度
 */
-(CGFloat)fs_getHeightWithConstrainedWidth:(CGFloat)width font:(UIFont *)font;
/**
 * 获取字符串的宽度
 * @param height 最大高度
 * @return 宽度
 */
-(CGFloat)fs_getWidthWithConstrainedHeight:(CGFloat)height font:(UIFont *)font;
@end


@interface NSAttributedString (FS)
/**
 * 获取字符串的高度
 * @param width 最大宽度
 * @return 高度
 */
-(CGFloat)fs_getHeightWithConstrainedWidth:(CGFloat)width;
/**
 * 获取字符串的宽度
 * @param height 最大高度
 * @return 宽度
 */
-(CGFloat)fs_getWidthWithConstrainedHeight:(CGFloat)height;

@end
