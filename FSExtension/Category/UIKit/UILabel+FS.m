//
// Created by Fussa on 2018/5/31.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UILabel+FS.h"
#import <CoreText/CoreText.h>


@implementation UILabel (FS)


- (void)fs_setText:(NSString *)text lineSpace:(CGFloat)lineSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, text.length)];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    [attributedString addAttribute:NSFontAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    self.attributedText = attributedString;
}


- (void)fs_setLineBreakByTruncatingLastLineMiddle {
    [self fs_setLineBreakByTruncatingLastLineInset:self.frame.size.width / 2];
}

- (void)fs_setLineBreakByTruncatingLastLineInset:(CGFloat)inset {
    NSArray *separatedLines = [self fs_getSeparatedLinesArray];
    if (!separatedLines || separatedLines.count == 0) {
        return;
    }
    NSMutableString *limitedText = [NSMutableString string];
    if ( separatedLines.count >= self.numberOfLines ) {
        for (int i = 0 ; i < self.numberOfLines; i++) {
            if ( i == self.numberOfLines - 1) {
                UILabel *lastLineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width - inset, MAXFLOAT)];
                lastLineLabel.font = self.font;
                lastLineLabel.text = separatedLines[(NSUInteger) (self.numberOfLines - 1)];
                lastLineLabel.lineBreakMode = self.lineBreakMode;
                NSArray *subSeparatedLines = [lastLineLabel fs_getSeparatedLinesArray];
                NSString *lastLineText = [subSeparatedLines firstObject];
                NSInteger lastLineTextCount = lastLineText.length;
                [limitedText appendString:[NSString stringWithFormat:@"%@...",[lastLineText substringToIndex:lastLineTextCount]]];
            } else {
                [limitedText appendString:separatedLines[i]];
            }
        }
    } else {
        [limitedText appendString:self.text];
    }
    self.text = limitedText;
}


- (NSArray *)fs_getSeparatedLinesArray {
    NSString *text = [self text];
    UIFont   *font = [self font];
    CGRect    rect = [self frame];

    if (text == nil) {
        return nil;
    }

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = self.lineBreakMode;
    paragraphStyle.alignment = self.textAlignment;

    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attStr.length)];
    [attStr addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, attStr.length)];

    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);

    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));

    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);

    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];

    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);

        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}

@end


@implementation UILabel (FS_AttributeText)

// 给label指定text的颜色、字体
- (void)fs_addAttributesText:(NSString *)text color:(UIColor *)color font:(UIFont *)font {
    NSRange range = [[self.attributedText string] rangeOfString:text];
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSForegroundColorAttributeName: color} range:range];
        [mat addAttributes:@{NSFontAttributeName: font} range:range];
        self.attributedText = mat;
    }
}

- (void)fs_addAttributesText:(CGFloat)lineSpacing {
    NSRange range = NSMakeRange(0, [self.attributedText string].length);
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
        paragraphStyle.lineSpacing = lineSpacing;
        [mat addAttributes:@{NSParagraphStyleAttributeName: paragraphStyle} range:range];
        self.attributedText = mat;
    }
}

- (void)fs_addAttributesLineOffset:(CGFloat)lineOffset {
    NSRange range = NSMakeRange(0, [self.attributedText string].length);
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSBaselineOffsetAttributeName: @(lineOffset)} range:range];
        self.attributedText = mat;
    }
}


- (void)fs_addAttributesLineSingle {
    NSRange range = NSMakeRange(0, [self.attributedText string].length);
    if (range.location != NSNotFound) {
        NSMutableAttributedString *mat = [self.attributedText mutableCopy];
        [mat addAttributes:@{NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle)} range:range];
        self.attributedText = mat;
    }
}

@end



