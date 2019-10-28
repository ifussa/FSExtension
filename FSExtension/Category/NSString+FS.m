//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "NSString+FS.h"


@implementation NSString (FS)
- (CGFloat)fs_getHeightWithConstrainedWidth:(CGFloat)width font:(UIFont *)font {
    CGSize constraintRect = CGSizeMake(width, CGFLOAT_MAX);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(boundingBox.size.height);
}
- (CGFloat)fs_getWidthWithConstrainedHeight:(CGFloat)height font:(UIFont *)font {
    CGSize constraintRect = CGSizeMake(CGFLOAT_MAX, height);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
    return ceil(boundingBox.size.width);
}


@end

@implementation NSAttributedString (FS)
- (CGFloat)fs_getHeightWithConstrainedWidth:(CGFloat)width {
    CGSize constraintRect = CGSizeMake(width, CGFLOAT_MAX);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return ceil(boundingBox.size.height);
}
- (CGFloat)fs_getWidthWithConstrainedHeight:(CGFloat)height {
    CGSize constraintRect = CGSizeMake(CGFLOAT_MAX, height);
    CGRect boundingBox = [self boundingRectWithSize:constraintRect options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    return ceil(boundingBox.size.width);
}
@end


