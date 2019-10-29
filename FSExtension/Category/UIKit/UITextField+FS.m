//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "UITextField+FS.h"
#import <objc/runtime.h>

static const void *FSTextFieldMaxLengthKey = &FSTextFieldMaxLengthKey;
static const void *FSTextFieldAddChangedKey = &FSTextFieldAddChangedKey;

@implementation UITextField (FS)

- (void)setFs_maxLength:(NSUInteger)fs_maxLength {
    objc_setAssociatedObject(self, &FSTextFieldMaxLengthKey, @(fs_maxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    BOOL isAdd = [objc_getAssociatedObject(self, &FSTextFieldAddChangedKey) boolValue];
    if (!isAdd) {
        [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        objc_setAssociatedObject(self, &FSTextFieldAddChangedKey, @YES, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSUInteger)fs_maxLength {
    return (NSUInteger) [objc_getAssociatedObject(self, &FSTextFieldMaxLengthKey) integerValue];
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField != self) {
        return;
    }
    NSUInteger kMaxLength = self.fs_maxLength;
    NSString *toBeString = textField.text;
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; //ios7之前使用[UITextInputMode currentInputMode].primaryLanguage
    if ([lang isEqualToString:@"zh-Hans"]) { //中文输入

        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if (!position) {// 没有高亮选择的字，则对已输入的文字进行字数统计和限制

            if (toBeString.length > kMaxLength) {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        } else{//有高亮选择的字符串，则暂不对文字进行统计和限制

        }

    }else{//中文输入法以外的直接对其统计限制即可，不考虑其他语种情况

        if (toBeString.length > kMaxLength) {
            textField.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

@end
