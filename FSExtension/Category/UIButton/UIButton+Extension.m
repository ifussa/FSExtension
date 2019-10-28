//
//  UIButton+Extension.m
//  Patient
//
//  Created by Fussa on 16/4/24.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

- (instancetype)fs_textButtonWithTile:(NSString *)title
                             fontSize:(CGFloat)fontSize
                          normalColor:(UIColor *)normalColor
                     highlightedColor:(UIColor *)highlightedColor
                  backgroundImageName:(NSString *)backgroundImageName {

    UIButton *button = [[UIButton alloc] init];

    button.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];

    UIImage *backgroundImage = [UIImage imageNamed:backgroundImageName];
    [button setBackgroundImage:backgroundImage forState:UIControlStateNormal];;

    NSString *highlightedBackgroundImageName = [NSString stringWithFormat:@"%@_highlighted", backgroundImageName];
    UIImage *highlightedBackgroundImage = [UIImage imageNamed:highlightedBackgroundImageName];
    [button setBackgroundImage:highlightedBackgroundImage forState:UIControlStateHighlighted];;

    [button sizeToFit];
    return button;
}

- (instancetype)fs_textButtonWithTile:(NSString *)title
                             fontSize:(CGFloat)fontSize
                          normalColor:(UIColor *)normalColor
                     highlightedColor:(UIColor *)highlightedColor {
    return [self fs_textButtonWithTile:title
                              fontSize:fontSize
                           normalColor:normalColor
                      highlightedColor:highlightedColor
                   backgroundImageName:NULL];
}

- (instancetype)fs_imageButtonWithImageName:(NSString *)imageName backgroundImageName:(NSString *)backgroundImageName {

    UIButton *button = [[UIButton alloc] init];

    UIImage *normalImage = [UIImage imageNamed:imageName];
    NSString *highlightImageName = [NSString stringWithFormat:@"%@_highlighted", imageName];
    UIImage *highlightImage = [UIImage imageNamed:highlightImageName];

    UIImage *normalBackgroundImage = [UIImage imageNamed:backgroundImageName];
    NSString *highlightBackgroundImageName = [NSString stringWithFormat:@"%@_highlighted", backgroundImageName];
    UIImage *highlightBackgroundImage = [UIImage imageNamed:highlightBackgroundImageName];

    [button setImage:normalImage forState:UIControlStateNormal];
    [button setImage:highlightImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:normalBackgroundImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightBackgroundImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    return button;
}

- (void)fs_setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding {
    if (self.imageView.image != nil && self.titleLabel.text != nil) {

        //先还原
        self.titleEdgeInsets = UIEdgeInsetsZero;
        self.imageEdgeInsets = UIEdgeInsetsZero;

        CGRect imageRect = self.imageView.frame;
        CGRect titleRect = self.titleLabel.frame;

        CGFloat totalHeight = imageRect.size.height + padding + titleRect.size.height;
        CGFloat selfHeight = self.frame.size.height;
        CGFloat selfWidth = self.frame.size.width;

        switch (style) {
            case ButtonImageTitleStyleLeft:
                if (padding != 0) {
                    self.titleEdgeInsets = UIEdgeInsetsMake(0,
                            padding / 2,
                            0,
                            -padding / 2);

                    self.imageEdgeInsets = UIEdgeInsetsMake(0,
                            -padding / 2,
                            0,
                            padding / 2);
                }
                break;
            case ButtonImageTitleStyleRight: {
                //图片在右，文字在左
                self.titleEdgeInsets = UIEdgeInsetsMake(0,
                        -(imageRect.size.width + padding / 2),
                        0,
                        (imageRect.size.width + padding / 2));

                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                        (titleRect.size.width + padding / 2),
                        0,
                        -(titleRect.size.width + padding / 2));
            }
                break;
            case ButtonImageTitleStyleTop: {
                //图片在上，文字在下
                self.titleEdgeInsets = UIEdgeInsetsMake(
                        ((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y),
                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                        -((selfHeight - totalHeight) / 2 + imageRect.size.height + padding - titleRect.origin.y),
                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);

                self.imageEdgeInsets = UIEdgeInsetsMake(
                        ((selfHeight - totalHeight) / 2 - imageRect.origin.y),
                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                        -((selfHeight - totalHeight) / 2 - imageRect.origin.y),
                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));

            }
                break;
            case ButtonImageTitleStyleBottom: {
                //图片在下，文字在上。
                self.titleEdgeInsets = UIEdgeInsetsMake(
                        ((selfHeight - totalHeight) / 2 - titleRect.origin.y),
                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                        -((selfHeight - totalHeight) / 2 - titleRect.origin.y),
                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);

                self.imageEdgeInsets = UIEdgeInsetsMake(
                        ((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y),
                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                        -((selfHeight - totalHeight) / 2 + titleRect.size.height + padding - imageRect.origin.y),
                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleCenterTop: {
                self.titleEdgeInsets = UIEdgeInsetsMake(
                        -(titleRect.origin.y - padding),
                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                        (titleRect.origin.y - padding),
                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);

                self.imageEdgeInsets = UIEdgeInsetsMake(
                        0,
                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                        0,
                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleCenterBottom: {
                self.titleEdgeInsets = UIEdgeInsetsMake(
                        (selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                        -(selfHeight - padding - titleRect.origin.y - titleRect.size.height),
                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);

                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                        0,
                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleCenterUp: {
                self.titleEdgeInsets = UIEdgeInsetsMake(
                        -(titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                        (titleRect.origin.y + titleRect.size.height - imageRect.origin.y + padding),
                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);

                self.imageEdgeInsets = UIEdgeInsetsMake(
                        0,
                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                        0,
                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleCenterDown: {
                self.titleEdgeInsets = UIEdgeInsetsMake(
                        (imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                        (selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2,
                        -(imageRect.origin.y + imageRect.size.height - titleRect.origin.y + padding),
                        -(selfWidth / 2 - titleRect.origin.x - titleRect.size.width / 2) - (selfWidth - titleRect.size.width) / 2);

                self.imageEdgeInsets = UIEdgeInsetsMake(
                        0,
                        (selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2),
                        0,
                        -(selfWidth / 2 - imageRect.origin.x - imageRect.size.width / 2));
            }
                break;
            case ButtonImageTitleStyleRightLeft: {
                //图片在右，文字在左，距离按钮两边边距
                self.titleEdgeInsets = UIEdgeInsetsMake(
                        0,
                        -(titleRect.origin.x - padding),
                        0,
                        (titleRect.origin.x - padding));

                self.imageEdgeInsets = UIEdgeInsetsMake(
                        0,
                        (selfWidth - padding - imageRect.origin.x - imageRect.size.width),
                        0,
                        -(selfWidth - padding - imageRect.origin.x - imageRect.size.width));
            }

                break;

            case ButtonImageTitleStyleLeftRight: {
                //图片在左，文字在右，距离按钮两边边距
                self.titleEdgeInsets = UIEdgeInsetsMake(
                        0,
                        (selfWidth - padding - titleRect.origin.x - titleRect.size.width),
                        0,
                        -(selfWidth - padding - titleRect.origin.x - titleRect.size.width));

                self.imageEdgeInsets = UIEdgeInsetsMake(0,
                        -(imageRect.origin.x - padding),
                        0,
                        (imageRect.origin.x - padding));
            }
                break;
            default:
                break;
        }
    } else {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

@end
