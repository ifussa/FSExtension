//
// Created by Yimi on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import "FSTool.h"
#import "sys/utsname.h"

@implementation FSTool
- (NSData *)resetSizeOfImageDataWith:(UIImage *)sourceImage maxSize:(NSInteger)maxSize {
    return [[NSData alloc] init];
    // 先判断当前质量是否满足要求，不满足再进行压缩
//    NSData *finallImageData = UIImageJPEGRepresentation(sourceImage, 1.0);
//    NSInteger sizeOrigin =  finallImageData.length;
//    NSInteger sizeOriginKB = sizeOrigin / 1024;
//    if (sizeOriginKB <= maxSize) {
//        return  finallImageData
//    }
//
//    //先调整分辨率
//    CGSize defaultSize = CGSizeMake(1024, 1024);
//    UIImage *newImage = [self newSizeImageWith:sourceImage maxSize:defaultSize];
//
//    finallImageData = UIImageJPEGRepresentation(newImage, 1.0);
//
//    //保存压缩系数
//    NSMutableArray *compressionQualityArr = [[NSMutableArray alloc] init];
//    CGFloat avg = 1.0 / 250;
//    CGFloat value = avg;
//
//    NSInteger i = 250;
//    while (i >=1 ){
//        i -= 1;
//        value = i * avg;
////        [compressionQualityArr addObject:value];
//    }


//    //先判断当前质量是否满足要求，不满足再进行压缩
//    var finallImageData = UIImageJPEGRepresentation(source_image,1.0)
//    let sizeOrigin      = finallImageData?.count
//    let sizeOriginKB    = sizeOrigin! / 1024
//    if sizeOriginKB <= maxSize {
//        return finallImageData! as NSData
//    }
//
//    //先调整分辨率
//    var defaultSize = CGSize(width: 1024, height: 1024)
//    let newImage = self.newSizeImage(size: defaultSize, source_image: source_image)
//
//    finallImageData = UIImageJPEGRepresentation(newImage,1.0);
//
//    //保存压缩系数
//    let compressionQualityArr = NSMutableArray()
//    let avg = CGFloat(1.0/250)
//    var value = avg
//
//    var i = 250
//    repeat {
//        i -= 1
//        value = CGFloat(i)*avg
//        compressionQualityArr.add(value)
//    } while i >= 1
//
//
//    /*
//     调整大小
//     说明：压缩系数数组compressionQualityArr是从大到小存储。
//     */
//    //思路：使用二分法搜索
//    finallImageData = self.halfFuntion(arr: compressionQualityArr.copy() as! [CGFloat], image: newImage, sourceData: finallImageData!, maxSize: maxSize)
//    //如果还是未能压缩到指定大小，则进行降分辨率
//    while finallImageData?.count == 0 {
//        //每次降100分辨率
//        if defaultSize.width-100 <= 0 || defaultSize.height-100 <= 0 {
//            break
//        }
//        defaultSize = CGSize(width: defaultSize.width-100, height: defaultSize.height-100)
//        let image = self.newSizeImage(size: defaultSize, source_image: UIImage.init(data: UIImageJPEGRepresentation(newImage, compressionQualityArr.lastObject as! CGFloat)!)!)
//        finallImageData = self.halfFuntion(arr: compressionQualityArr.copy() as! [CGFloat], image: image, sourceData: UIImageJPEGRepresentation(image,1.0)!, maxSize: maxSize)
//    }
//
//    return finallImageData! as NSData

}

/**
 * 调整图片分辨率/尺寸（等比例缩放）
 * @param sourceImage
 * @param size
 * @return
 */
- (UIImage *)newSizeImageWith:(UIImage *)sourceImage maxSize:(CGSize)size {
    CGSize newSize = CGSizeMake(sourceImage.size.width, sourceImage.size.height);
    CGFloat tempHeight = newSize.height / size.height;
    CGFloat tempWidth = newSize.width / size.width;

    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempHeight);
    } else if (tempHeight > 1.0 && tempWidth < tempHeight) {
        newSize = CGSizeMake(sourceImage.size.width / tempWidth, sourceImage.size.height / tempHeight);
    }

    UIGraphicsBeginImageContext(newSize);
    [sourceImage drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (CIImage *)creatCIQRCodeImageWith:(NSString *)url {
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认设置
    [filter setDefaults];
    // 3. 给过滤器添加数据
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4. 生成二维码
    CIImage *outputImage = filter.outputImage;
    // 5. 返回二维码
    return outputImage;
}

- (void)setupStatusBarWithColor:(UIColor *)color {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}

+ (NSString *)getDeviceName {

    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"]) return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"]) return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"iPhone X";
    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";
    if ([deviceString isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"]) return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"]) return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"]) return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"]) return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"]) return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"i386"]) return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"]) return @"Simulator";
    return deviceString;
}

@end