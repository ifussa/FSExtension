//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^BatteryInfoBlack)(NSString *state, float level);

@interface UIApplication (FS)
/*** 获取设备信息 ***/
- (NSString *)fs_UUIDString;
- (NSString *)fs_getIPAddress;
- (NSString *)fs_systemVersion;

/*** 获取App相关信息 ***/
- (NSString *)fs_getAppName;
- (NSString *)fs_getAppVersion;
- (NSString *)fs_getAppBuildVersion;

/*** 播放系统声音、提醒声音和振动设备 ***/
- (void)fs_notice_vibrate;
- (void)fs_notice_playSystemSound;
- (void)fs_notice_playAlertSound;

/*** 获取电池的相关信息 ***/
- (float)fs_getBatteryLevel;
- (NSString *)fs_getBatteryState;
- (void)fs_getBatteryInfoBlack:(BatteryInfoBlack)batteryInfo;

/*** 获取网络运营商 ***/
- (NSString *)fs_subscriberCellularProvider;
/*** 获取当前网络类型 ***/
- (NSString *)fs_RadioAccessTechnologyConnectType;

@end