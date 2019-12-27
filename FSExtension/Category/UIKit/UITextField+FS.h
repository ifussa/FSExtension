//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UITextField (FS)

/**
 * 限制输入字数
 */
@property (nonatomic,assign) NSUInteger fs_maxLength;


#pragma mark - placeHolder


- (void)fs_setColor:(nullable UIColor *)color font:(nullable UIFont *)font;


/**
 * 设置 placeHolder 文字
 */
- (void)fs_setPlaceholderFont:(UIFont *)font;

/**
 * 设置 placeHolder 颜色
 */
- (void)fs_setPlaceholderColor:(UIColor *)color;

/**
 * 设置 placeHolder 颜色和文字
 */
- (void)fs_setPlaceholderColor:(nullable UIColor *)color font:(nullable UIFont *)font;

/**
 * 检查 placeHolder 是否为空
 */
- (BOOL)fs_checkPlaceholderEmpty;
@end