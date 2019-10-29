//
// Created by Fussa on 2019/10/29.
// Copyright (c) 2019 Fussa. All rights reserved.
//

#import "UIApplication+FS.h"

// IP
#import <ifaddrs.h>
#import <arpa/inet.h>
// 设备模型型号
#import <sys/utsname.h>
// 获取运营商的信息
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
// 播放系统声音、提醒声音和振动设备
#import <AudioToolbox/AudioToolbox.h>

@implementation UIApplication (FS)

- (NSString *)fs_UUIDString {
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)fs_systemVersion {
    return [UIDevice currentDevice].systemVersion;
}

- (NSString *)fs_getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}
- (NSString *)fs_getAppBuildVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (NSString *)fs_getAppName {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
}

- (NSString *)fs_getIPAddress {
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

- (NSString *)fs_subscriberCellularProvider {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [info subscriberCellularProvider];
    return [NSString stringWithFormat:@"%@",[carrier carrierName]];
}

- (NSString *)fs_RadioAccessTechnologyConnectType {
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    NSString *mConnectType = [[NSString alloc] initWithFormat:@"%@",info.currentRadioAccessTechnology];
    /***

     CTRadioAccessTechnologyGPRS             // 介于2G和3G之间，也叫2.5G ,过度技术
     CTRadioAccessTechnologyEdge             // EDGE为GPRS到第三代移动通信的过渡，EDGE俗称2.75G
     CTRadioAccessTechnologyWCDMA
     CTRadioAccessTechnologyHSDPA            // 亦称为3.5G(3?G)
     CTRadioAccessTechnologyHSUPA            // 3G到4G的过度技术
     CTRadioAccessTechnologyCDMA1x           // 3G
     CTRadioAccessTechnologyCDMAEVDORev0     // 3G标准
     CTRadioAccessTechnologyCDMAEVDORevA
     CTRadioAccessTechnologyCDMAEVDORevB
     CTRadioAccessTechnologyeHRPD            // 电信使用的一种3G到4G的演进技术， 3.75G
     CTRadioAccessTechnologyLTE              // 接近4G

     ***/
    return mConnectType;
}

- (void)fs_notice_playSystemSound
{
    // 播放系统声音
    AudioServicesPlaySystemSound(1005);
}

- (void)fs_notice_playAlertSound
{
    // 播放提醒声音
    AudioServicesPlayAlertSound(1006);
}

- (void)fs_notice_vibrate
{
    // 执行震动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (NSString *)fs_getBatteryState
{
    UIDevice *device = [UIDevice currentDevice];
    if (device.batteryState == UIDeviceBatteryStateUnknown) {
        return @"UnKnow";
    } else if (device.batteryState == UIDeviceBatteryStateUnplugged) {
        return @"Unplugged";
    } else if (device.batteryState == UIDeviceBatteryStateCharging) {
        return @"Charging";
    } else if (device.batteryState == UIDeviceBatteryStateFull) {
        return @"Full";
    }
    return nil;
}

// 获取电量的等级，0.00 ~ 1.00
- (float)fs_getBatteryLevel
{
    return [UIDevice currentDevice].batteryLevel;
}

- (void)fs_getBatteryInfoBlack:(BatteryInfoBlack)batteryInfo
{
    NSString *state = [self fs_getBatteryState];
    float level = [self fs_getBatteryLevel] * 100.0;
    batteryInfo(state,level);
    //yourControlFunc(state, level);  //写自己要实现的获取电量信息后怎么处理
}

@end