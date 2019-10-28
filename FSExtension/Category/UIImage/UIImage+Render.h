//
//  UIImage+Render.h
//  Patient
//
//  Created by Fussa on 16/4/21.
//  Copyright © 2016年 gxwj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Render)

/**
 *  设置的图片不渲染
 *
 *  @param imageName 要设置的图片名称
 *
 *  @return 返回设置好的图片
 */
+ (UIImage *)imageWithOriginalRender:(NSString *)imageName;
@end
