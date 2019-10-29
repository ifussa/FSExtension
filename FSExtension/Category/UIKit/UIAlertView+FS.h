//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIAlertView (FS)

/**
 *用Block的方式回调代理(alertView: clickedButtonAtIndex:)方法,如果还需要执行其他的代理方法请设置delegate,并遵守协议<UIAlertDelegate>
 */
- (void)fs_showAlertViewWithClickedButtonBlock:(void (^)(NSInteger buttonIndex))block
                                 otherDelegate:(id)delegate;

@end