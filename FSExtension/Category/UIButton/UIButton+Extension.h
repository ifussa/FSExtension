//
//  UIButton+Extension.h
//  Patient
//
//  Created by Fussa on 16/4/24.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
  针对同时设置了Image和Title的场景时UIButton中的图片和文字的关系
 */
typedef NS_ENUM(NSInteger, ButtonImageTitleStyle) {
    ButtonImageTitleStyleDefault = 0,       //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleLeft = 0,          //图片在左，文字在右，整体居中。
    ButtonImageTitleStyleRight = 2,         //图片在右，文字在左，整体居中。
    ButtonImageTitleStyleTop = 3,           //图片在上，文字在下，整体居中。
    ButtonImageTitleStyleBottom = 4,        //图片在下，文字在上，整体居中。
    ButtonImageTitleStyleCenterTop = 5,     //图片居中，文字在上距离按钮顶部。
    ButtonImageTitleStyleCenterBottom = 6,  //图片居中，文字在下距离按钮底部。
    ButtonImageTitleStyleCenterUp = 7,      //图片居中，文字在图片上面。
    ButtonImageTitleStyleCenterDown = 8,    //图片居中，文字在图片下面。
    ButtonImageTitleStyleRightLeft = 9,     //图片在右，文字在左，距离按钮两边边距
    ButtonImageTitleStyleLeftRight = 10,    //图片在左，文字在右，距离按钮两边边距
};

@interface UIButton (Extension)

//@property (nonatomic, strong) NSString *subtitle;

/**
 调整按钮的文本和image的布局，前提是title和image同时存在才会调整。
 padding是调整布局时整个按钮和图文的间隔。

 @param style 样式
 @param padding 间距
 */
- (void)fs_setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;

/**
 * 创建按钮
 * @param title 按钮文字
 * @param fontSize 文字大小
 * @param normalColor 颜色
 * @param highlightedColor 高亮颜色
 * @param backgroundImageName 背景图片
 * @return
 */
- (instancetype) fs_textButtonWithTile: (NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor backgroundImageName:(NSString *)backgroundImageName;
/**
 * 创建按钮
 * @param title 按钮文字
 * @param fontSize 文字大小
 * @param normalColor 颜色
 * @param highlightedColor 高亮颜色
 * @return
 */
- (instancetype) fs_textButtonWithTile: (NSString *)title fontSize:(CGFloat)fontSize normalColor:(UIColor *)normalColor highlightedColor:(UIColor *)highlightedColor;

/**
 * 创建图片按钮
 * @param imageName 按钮图片
 * @param backgroundImageName 背景图片
 * @return 按钮
 */
- (instancetype) fs_imageButtonWithImageName: (NSString *)imageName  backgroundImageName:(NSString *)backgroundImageName;
@end
