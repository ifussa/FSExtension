//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FSApp : NSObject


/*
 * 判断是否是异形屏
 */
+(BOOL)isiPhoneXScreen;

/*
 * 取消UIScrollView自适应
 */
+(void)neverAdjustsContentInsetForScrollView:(UIScrollView *)scrollView;

+(void)neverAdjustsContentInsetForViewController:(UIViewController *)VC;



@end