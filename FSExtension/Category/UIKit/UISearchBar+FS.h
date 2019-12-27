//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar (FS)

/**
 * 统一设置searchBar
 * @param tintColor 按钮文字颜色
 * @param barTintColor 颜色主题
 * @param borderColor 圆角和边框颜色
 * @param placeholder placeholder
 */
- (void)fs_setSearchBarWithTintColor:(UIColor *)tintColor barTintColor:(UIColor *)barTintColor borderColor:(UIColor *)borderColor placeholder:(NSString *)placeholder;

/**
 * 设置searchField
 * @param cornerRadius 输入框圆角半径
 * @param borderColor 输入框边框颜色
 */
- (void)fs_setSearchFieldWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor;

/**
 * 设置searchField
 * @param borderColor 输入框圆角半径
 */
- (void)fs_setSearchFieldWithBorderColor:(UIColor *)borderColor;

/**
 * 设置取消按钮文字
 * @param title 按钮标题
 */
- (void)fs_setCancelButtonWithTitle:(NSString *)title;

/**
 * 获取SearchBar系统自带的TextField
 */
- (void)fs_getSearchTextFieldWithCompletionBlock:(void(^)(UITextField *textField))completionBlock;

@end