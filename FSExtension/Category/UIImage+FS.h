//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (FS)
/**
 * 生成二维码
 * @param string 二维码地址
 * @param ImageSize  尺寸
 * @param waterImageSize 水印尺寸
 * @return
 */
+ (UIImage *)fs_qrImageForString:(NSString *)string imageSize:(CGFloat)ImageSize logoImageSize:(CGFloat)waterImageSize;
/**
 * 从CIImage创建高清图片
 * @param image
 * @param size
 * @param waterImageSize
 * @return
 */
- (UIImage *)fs_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size waterImageSize:(CGFloat)waterImageSize;
/**
 * 修改图片（二维码）颜色
 * @param image
 * @param red
 * @param green
 * @param blue
 * @return
 */
- (UIImage*)fs_imageBlackToTransparent:(UIImage *)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;
@end


@interface UIImage (FSRender)

/**
 *  设置的图片不渲染
 *
 *  @param imageName 要设置的图片名称
 *
 *  @return 返回设置好的图片
 */
+ (UIImage *)fs_imageWithOriginalRender:(NSString *)imageName;
@end
