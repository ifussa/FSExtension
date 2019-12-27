//
// Created by Fussa on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (FS)

/**
 * 设置UILabel行高
 * @param text 文本
 * @param lineSpace 行高
 */
- (void)fs_setText:(NSString *)text lineSpace:(CGFloat)lineSpace;

/**
 * 设置最后一行结尾缩进, 并多余的显示省略号
 * @param inset 缩进量
 */
- (void)fs_setLineBreakByTruncatingLastLineInset:(CGFloat)inset;


/**
  设置最后一行结尾缩进到行中间, 显示省略号
 */
- (void)fs_setLineBreakByTruncatingLastLineMiddle;

/**
 分割成行数组
 @return 各个行组成的数组
 */
- (NSArray *)fs_getSeparatedLinesArray;

@end

@interface UILabel (FS_AttributeText)

// 给label指定text的颜色、字体
- (void)fs_addAttributesText:(NSString *)text color:(UIColor *)color font:(UIFont *)font;

- (void)fs_addAttributesText:(CGFloat)lineSpacing;

- (void)fs_addAttributesLineOffset:(CGFloat)lineOffset;

- (void)fs_addAttributesLineSingle;

@end