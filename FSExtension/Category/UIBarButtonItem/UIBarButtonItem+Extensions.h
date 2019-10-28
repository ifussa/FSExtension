//
// Created by Yimi on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIBarButtonItem (Extensions)
/**
 * 创建UIBarButtonItem
 * @param title 标题
 * @param target target
 * @param action action
 * @return
 */
- (instancetype)initWithTitle: (NSString *)title target: (nullable id)target action: (SEL)action;

/**
 * 创建UIBarButtonItem
 * @param title 标题
 * @param image 图片
 * @param highlightedImage 高亮图片
 * @param target target
 * @param action action
 * @return
 */
- (instancetype)initWithTitle: (NSString *)title image: (UIImage *)image highlightedImage:(UIImage *)highlightedImage target: (nullable id) target action: (SEL)action;
@end