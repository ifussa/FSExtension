//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "NSAttributedString+Extension.h"


@implementation NSAttributedString (Extension)
- (CGFloat)getHeightWithConstrainedWidth:(CGFloat)width {
    CGSize constraintRect = CGSizeMake(width, CGFLOAT_MAX);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return ceil(boundingBox.size.height);
}
- (CGFloat)getWidthWithConstrainedHeight:(CGFloat)height {
    CGSize constraintRect = CGSizeMake(CGFLOAT_MAX, height);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return ceil(boundingBox.size.width);
}
@end