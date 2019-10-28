//
//  UIImage+Render.m
//  Patient
//
//  Created by Fussa on 16/4/21.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import "UIImage+Render.h"

@implementation UIImage (Render)


/**
 *  设置的图片不渲染
 *
 *  @param imageName 要设置的图片名称
 *
 *  @return 返回设置好的图片
 */
+ (UIImage *)imageWithOriginalRender:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    
    // 始终绘制图片原始状态，不使用Tint Color。
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
