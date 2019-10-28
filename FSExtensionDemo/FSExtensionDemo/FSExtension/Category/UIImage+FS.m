//
// Created by Fussa on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "UIImage+FS.h"


@implementation UIImage (FS)
/**
 * 生成二维码
 * @param string 二维码地址
 * @param ImageSize  尺寸
 * @param waterImageSize 水印尺寸
 * @return
 */
+ (UIImage *)fs_qrImageForString:(NSString *)string imageSize:(CGFloat)ImageSize logoImageSize:(CGFloat)waterImageSize {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];//通过kvo方式给一个字符串，生成二维码
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];//设置二维码的纠错水平，越高纠错水平越高，可以污损的范围越大
    CIImage *outPutImage = [filter outputImage];//拿到二维码图片
    return [[self alloc] fs_createNonInterpolatedUIImageFormCIImage:outPutImage withSize:ImageSize waterImageSize:waterImageSize];
}

/**
 * 从CIImage创建高清图片
 * @param image
 * @param size
 * @param waterImageSize
 * @return
 */
- (UIImage *)fs_createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size waterImageSize:(CGFloat)waterImageSize {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));

    // 1.创建bitmap;
    size_t width = (size_t) (CGRectGetWidth(extent) * scale);
    size_t height = (size_t) (CGRectGetHeight(extent) * scale);
    //创建一个DeviceGray颜色空间
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    //CGBitmapContextCreate(void * _Nullable data, size_t width, size_t height, size_t bitsPerComponent, size_t bytesPerRow, CGColorSpaceRef  _Nullable space, uint32_t bitmapInfo)
    //width：图片宽度像素
    //height：图片高度像素
    //bitsPerComponent：每个颜色的比特值，例如在rgba-32模式下为8
    //bitmapInfo：指定的位图应该包含一个alpha通道。

    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    //创建CoreGraphics image
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];

    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);

    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef); CGImageRelease(bitmapImage);

    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];


     // 注：
     // 二维码上加logo图的时候，图片很模糊，这是由于UIGraphicsBeginImageContextWithOptions里的 scale 造成的，
     // 由于 iPhone 的屏幕都是retina屏幕，都是2倍，3倍像素，这里的 scale 要根据屏幕来设置
     // 即[[UIScreen mainScreen] scale]这样图片就会很清晰

    //给二维码加 logo 图
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    //logo图
    UIImage *waterimage = [UIImage imageNamed:@"icon_imgApp"];
    //把logo图画到生成的二维码图片上，注意尺寸不要太大（最大不超过二维码图片的%30），太大会造成扫不出来
    [waterimage drawInRect:CGRectMake((size-waterImageSize)/2.0, (size-waterImageSize)/2.0, waterImageSize, waterImageSize)];
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newPic;

}

/**
 * 修改图片（二维码）颜色
 * @param image 要修改的图片
 * @param red
 * @param green
 * @param blue
 * @return
 */
- (UIImage*)fs_imageBlackToTransparent:(UIImage *)image withRed:(CGFloat)red andGreen:(CGFloat)green andBlue:(CGFloat)blue{
    const int imageWidth = (const int) image.size.width;
    const int imageHeight = (const int) image.size.height;
    size_t bytesPerRow = (size_t) (imageWidth * 4);
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, (size_t) imageWidth, (size_t) imageHeight, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage); // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) // 将白色变成透明
        {
            // 改成下面的代码，会将图片转成想要的颜色
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = (uint8_t) red; //0~255
            ptr[2] = (uint8_t) green;
            ptr[1] = (uint8_t) blue;
        } else {
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    // 输出图片
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef imageRef = CGImageCreate((size_t) imageWidth, (size_t) imageHeight, 8, 32, bytesPerRow, colorSpace, (CGBitmapInfo) (kCGImageAlphaLast | kCGBitmapByteOrder32Little), dataProvider, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef]; // 清理空间
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return resultUIImage;
}
@end


@implementation UIImage (FSRender)


/**
 *  设置的图片不渲染
 *
 *  @param imageName 要设置的图片名称
 *
 *  @return 返回设置好的图片
 */
+ (UIImage *)fs_imageWithOriginalRender:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];

    // 始终绘制图片原始状态，不使用Tint Color。
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

@end
