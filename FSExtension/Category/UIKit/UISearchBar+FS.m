//
// Created by Yimi on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UISearchBar+FS.h"


@implementation UISearchBar (FS)

/**
 * 统一设置searchBar
 * @param tintColor 按钮文字颜色
 * @param barTintColor 颜色主题
 * @param borderColor 圆角和边框颜色
 * @param placeholder placeholder
 */
- (void)fs_setSearchBarWithTintColor:(UIColor *)tintColor barTintColor:(UIColor *)barTintColor borderColor:(UIColor *)borderColor placeholder:(NSString *)placeholder {
    //设置背景图是为了去掉上下黑线
    self.backgroundImage = [[UIImage alloc] init];
    // 设置SearchBar的颜色主题为白色
    self.barTintColor = barTintColor;
    //设置圆角和边框颜色
    [self fs_setSearchFieldWithBorderColor:borderColor];
    //设置按钮文字和颜色
    self.tintColor = tintColor;
    self.placeholder = placeholder;
}


/**
 * 设置searchField
 * @param cornerRadius 输入框圆角半径
 * @param borderColor 输入框边框颜色
 */
- (void)fs_setSearchFieldWithCornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor {
    UITextField *searchField = [self valueForKey:[NSString stringWithFormat:@"searchField"]];
    searchField.backgroundColor = [UIColor whiteColor];
    searchField.layer.cornerRadius = cornerRadius;
    searchField.layer.borderColor = borderColor.CGColor;
    searchField.layer.borderWidth = 1;
    searchField.layer.masksToBounds = YES;
    searchField.returnKeyType = UIReturnKeySearch;
    searchField.tintColor = [UIColor lightGrayColor];
}

/**
 * 设置searchField
 * @param borderColor 输入框圆角半径
 */
- (void)fs_setSearchFieldWithBorderColor:(UIColor *)borderColor {
    [self fs_setSearchFieldWithCornerRadius:14.0 borderColor:borderColor];
}

/**
 * 设置取消按钮文字
 * @param title 按钮标题
 */
- (void)fs_setCancelButtonWithTitle:(NSString *)title {
    UIButton *cancelButton = [self valueForKey:[NSString stringWithFormat:@"cancelButton"]];
    [cancelButton setTitle:title forState:UIControlStateNormal];
}


@end