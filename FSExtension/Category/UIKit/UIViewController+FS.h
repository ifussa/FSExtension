//
//  UIViewController+FS.h
//  FSExtensionDemo
//
// Created by 曾福生 on 2019/12/28.
// Copyright (c) 2019 Fussa. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIViewController (FS)

@end


@interface UIViewController (FS_ChangeDefaultPresentStyle)

/**
 Whether or not to set ModelPresentationStyle automatically for instance, Default is [Class fs_automaticallySetModalPresentationStyle].
 设置当前实例是否自动设置ModelPresentationStyle. 默认是[Class fs_automaticallySetModalPresentationStyle].
*/
@property (nonatomic, assign) BOOL fs_automaticallySetModalPresentationStyle;

/**
 Whether or not to set ModelPresentationStyle automatically, Default is YES, but UIImagePickerController/UIAlertController is NO.
 是否设置当前类自动设置ModelPresentationStyle, 默认是为 YES; UIImagePickerController/UIAlertController除外, 默认为NO;

 @return BOOL
 */
+ (BOOL)fs_automaticallySetModalPresentationStyle;

@end
