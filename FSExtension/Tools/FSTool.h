//
// Created by Yimi on 2018/5/30.
// Copyright (c) 2018 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface FSTool : NSObject
- (NSData *)resetSizeOfImageDataWith:(UIImage *)sourceImage maxSize:(NSInteger)maxSize;

- (UIImage *)newSizeImageWith:(UIImage *)sourceImage maxSize:(CGSize)size;

- (NSData *)halfFuntionWithArray:(NSArray *)arr image:(UIImage *)image sourceData:(NSData *)sourceData maxSize:(NSInteger)maxSize;

- (CIImage *)creatCIQRCodeImageWith:(NSString *)url;

/**
 设置导航栏颜色

 @param color 要设置的颜色
 */
- (void)setupStatusBarWithColor:(UIColor *)color;

+ (NSString *)getDeviceName;
@end