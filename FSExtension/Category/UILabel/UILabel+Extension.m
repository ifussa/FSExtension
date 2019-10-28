//
// Created by Fussa on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UILabel+Extension.h"


@implementation UILabel (Extension)

/**
 * 设置UILable行高
 * @param text 文本
 * @param lineSpace 行高
 */
- (void)setText:(NSString *)text lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attributedString addAttribute:NSFontAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
}

@end