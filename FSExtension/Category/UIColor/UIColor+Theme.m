//
// Created by Yimi on 2018/6/1.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UIColor+Theme.h"


@implementation UIColor (Theme)
+ (instancetype)themeColor {
    return [UIColor fs_colorWithHexString:KNormalColorString];
}
@end