//
//  FSDevice.h
//  FSExtensionDemo
//
// Created by 曾福生 on 2020/2/12.
// Copyright (c) 2020 Fussa. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface FSDevice : NSObject

/** 获取mac地址 */
+ (NSString *)getMacAddress;

/** 获取设备型号 */
+ (const NSString *)getDeviceName;

/** 获取设备电池容量，单位 mA 毫安 */
+ (NSInteger)getBatteryCapacity;

/** 获取电池电压，单位 V 福特 */
+ (CGFloat)getBatterVolocity;

/** 获取设备装机时的系统版本（最低支持版本） */
+ (const NSString *)getInitialFirmware;

/** 获取设备可支持的最高系统版本 */
+ (const NSString *)getLatestFirmware;

/** 广告位标识符 (在同一个设备上的所有App都会取到相同的值，是苹果专门给各广告提供商用来追踪用户而设的，用户可以在 设置|隐私|广告追踪里重置此id的值，或限制此id的使用，故此id有可能会取不到值，但好在Apple默认是允许追踪的，而且一般用户都不知道有这么个设置，所以基本上用来监测推广效果，是戳戳有余了) */
+ (NSString *)getIDFA;

+ (NSString *)getDeviceModel;

/** 能否打电话 */
+ (BOOL)canMakePhoneCall;

/** 获取设备上次重启的时间 */
+ (NSDate *)getSystemUptime;

+ (NSUInteger)getCPUFrequency;

/** 获取总线程频率 */
+ (NSUInteger)getBusFrequency;

/** 获取当前设备主存 */
+ (NSUInteger)getRamSize;

/** 获取CPU数量 */
+ (NSUInteger)getCPUCount;

/** 获取CPU处理器名称 */
+ (const NSString *)getCPUProcessor;

/** 获取CPU总的使用百分比 */
+ (float)getCPUUsage;

/** 获取单个CPU使用百分比 */
+ (NSArray *)getPerCPUUsage;


/** 获取本 App 所占磁盘空间 */
+ (NSString *)getApplicationSize;

/** 获取磁盘总空间 */
+ (int64_t)getTotalDiskSpace;

/** 获取未使用的磁盘空间 */
+ (int64_t)getFreeDiskSpace;

/** 获取已使用的磁盘空间 */
+ (int64_t)getUsedDiskSpace;

/** 获取总内存空间 */
+ (int64_t)getTotalMemory;

/** 获取活跃的内存空间 */
+ (int64_t)getActiveMemory;

/** 获取不活跃的内存空间 */
+ (int64_t)getInActiveMemory;

/** 获取空闲的内存空间 */
+ (int64_t)getFreeMemory;

/** 获取正在使用的内存空间 */
+ (int64_t)getUsedMemory;

/** 获取存放内核的内存空间 */
+ (int64_t)getWiredMemory;

/** 获取可释放的内存空间 */
+ (int64_t)getPurgableMemory;

@end