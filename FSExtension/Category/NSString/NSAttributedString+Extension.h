//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)
/**
 * 获取字符串的高度
 * @param width 最大宽度
 * @return 高度
 */
-(CGFloat)getHeightWithConstrainedWidth:(CGFloat)width;
/**
 * 获取字符串的宽度
 * @param height 最大高度
 * @return 宽度
 */
-(CGFloat)getWidthWithConstrainedHeight:(CGFloat)height;
@end