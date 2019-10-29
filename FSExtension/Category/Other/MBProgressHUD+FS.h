//
//  MBProgressHUD+FS.h
//
//  Created by fussa on 19-10-28.
//  Copyright (c) 2013年 com.ifussa. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (FS)
/**
 * 显示成功Toast
 * @param success 提示文字
 * @param view 要添加到的父视图
 */
+ (void)fs_showSuccess:(NSString *)success toView:(UIView *)view;

/**
 * 显示错误Toast
 * @param error 提示文字
 * @param view 要添加到的父视图
 */
+ (void)fs_showError:(NSString *)error toView:(UIView *)view;

/**
 * 显示提示Toast
 * @param message 提示文字
 * @param view 要添加到的父视图
 */
+ (MBProgressHUD *)fs_showMessage:(NSString *)message toView:(UIView *)view;

/**
 * 显示Loading
 * @param text 提示文字
 */
+ (void)fs_showLoading:(NSString *)text;

/**
 * 显示成功Toast
 * @param success 提示文字
 */
+ (void)fs_showSuccess:(NSString *)success;

/**
 * 显示失败Toast
 * @param error 提示文字
 */
+ (void)fs_showError:(NSString *)error;

/**
 * 显示提示文字
 * @param message 提示文字
 */
+ (MBProgressHUD *)fs_showMessage:(NSString *)message;

/**
 * 隐藏提示
 * @param view 父视图
 */
+ (void)fs_hideHUDForView:(UIView *)view;

/**
 * 隐藏提示
 */
+ (void)fs_hideHUD;

@end
