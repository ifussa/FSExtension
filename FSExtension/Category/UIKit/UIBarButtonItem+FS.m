//
// Created by Yimi on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UIBarButtonItem+FS.h"
#import "UIButton+FS.h"

@implementation UIBarButtonItem (FS)
- (instancetype)fs_initWithTitle:(NSString *)title target:(nullable id)target action:(SEL)action {
    return [self fs_initWithTitle:title image:NULL highlightedImage:NULL target:target action:action];
}

- (instancetype)fs_initWithTitle:(NSString *)title image:(UIImage *)image highlightedImage:(UIImage *)highlightedImage target:(nullable id)target action:(SEL)action {
    UIButton *button = [[UIButton alloc] fs_textButtonWithTile:title fontSize:17 normalColor:[UIColor whiteColor] highlightedColor:[UIColor whiteColor]];
    [button setTitle:title forState:UIControlStateNormal];

    [button setImage:image forState:UIControlStateNormal];
    [button setImage:highlightedImage forState:UIControlStateHighlighted];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    return [self initWithCustomView:button];
}
@end