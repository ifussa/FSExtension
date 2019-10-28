//
//  UINavigationBar+Awesome.h
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (FS)
- (void)fs_setBackgroundColor:(UIColor *)backgroundColor;
- (void)fs_setElementsAlpha:(CGFloat)alpha;
- (void)fs_setTranslationY:(CGFloat)translationY;
- (void)fs_reset;
- (void)fs_hideNavigationBarBottomLine:(BOOL)hide;
@end

@interface UINavigationBar (FSBackItem_iOS11)
@end
