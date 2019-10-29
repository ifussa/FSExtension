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
 */
+ (UIImage *)fs_qrImageForString:(NSString *)string imageSize:(CGFloat)ImageSize logoImageSize:(CGFloat)waterImageSize;
/**
 * 从CIImage创建高清图片
 * @param image
 * @param size
 * @param waterImageSize
 */
- (UIImage *)fs_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size waterImageSize:(CGFloat)waterImageSize;
/**
 * 修改图片（二维码）颜色
 * @param image
 * @param red
 * @param green
 * @param blue
 */
- (UIImage*)fs_imageBlackToTransparent:(UIImage *)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue;


/**
 *  高性能绘制圆角图片
 *
 *  @param size       图片尺寸
 *  @param fillColor  圆角图片外围填充色
 *  @param completion 完成回调,返回圆角图片
 */
- (void)fs_cornerImageWithSize:(CGSize)size fillClolor:(UIColor *)fillColor completion:(void(^)(UIImage *img))completion;

/**
 *  高性能绘制固定尺寸图片
 *
 *  @param size       所生成的图片尺寸
 *  @param completion 完成回调,返回固定尺寸图片
 */
- (void)fs_ImageWithSize:(CGSize)size completion:(void(^)(UIImage *img))completion;

/**
 *  创建纯色图片
 *
 *  @param color     生成纯色图片的颜色
 *  @param imageSize 需要创建纯色图片的尺寸
 *
 *  @return 纯色图片
 */
+ (UIImage *)fs_createImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;

/**
 *  创建圆角图片
 *
 *  @param originalImage 原始图片
 *
 *  @return 带圆角的图片
 */
+ (UIImage *)fs_imageWithOriginalImage:(UIImage *)originalImage;

/**
 *  创建圆角纯色图片
 *
 *  @param color     设置圆角纯色图片的颜色
 *  @param imageSize 设置元角纯色图片的尺寸
 *
 *  @return 圆角纯色图片
 */
+ (UIImage *)fs_createRoundedImageWithColor:(UIColor *)color withSize:(CGSize)imageSize;

/**
 *  生成带圆环的圆角图片
 *
 *  @param originalImage 原始图片
 *  @param borderColor   圆环颜色
 *  @param borderWidth   圆环宽度
 *
 *  @return 带圆环的圆角图片
 */
+ (UIImage *)fs_imageWithOriginalImage:(UIImage *)originalImage withBorderColor:(UIColor *)borderColor withBorderWidth:(CGFloat)borderWidth;

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
