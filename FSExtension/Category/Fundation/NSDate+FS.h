//
//  NSDate+Utils.h
//  BloodSugar
//
//  Created by PeterPan on 13-12-27.
//  Copyright (c) 2013年 shake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDate (FS)

+ (NSDate *)fs_dateWithYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day
                       hour:(NSInteger)hour
                     minute:(NSInteger)minute
                     second:(NSInteger)second;

+ (NSInteger)fs_daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (NSDate *)fs_dateWithHour:(int)hour
                     minute:(int)minute;

#pragma mark - Getter
- (NSInteger)fs_year;
- (NSInteger)fs_month;
- (NSInteger)fs_day;
- (NSInteger)fs_hour;
- (NSInteger)fs_minute;
- (NSInteger)fs_second;
- (NSString *)fs_weekday;

#pragma mark - Compare

@property (nonatomic,assign, readonly)BOOL isToday;        ///< 是否是今天
@property (nonatomic,assign, readonly)BOOL isYesterday;    ///< 是否是昨天
@property (nonatomic,assign, readonly)BOOL isTomorrow;     ///< 是否是明天
@property (nonatomic,assign, readonly)BOOL isWeekend;      ///< 是否是周末

- (BOOL)fs_isToday;
- (BOOL)fs_isYesterday;
- (BOOL)fs_isTomorrow;
- (BOOL)fs_isWeekend;

/// 两个日期是否是同一天
+ (BOOL)fs_isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2;


#pragma mark - Time string
- (NSString *)fs_timeHourMinute;
- (NSString *)fs_timeHourMinuteWithPrefix;
- (NSString *)fs_timeHourMinuteWithSuffix;
- (NSString *)fs_timeHourMinuteWithPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix;

#pragma mark - Date String
- (NSString *)fs_stringTimeHHmm;
- (NSString *)fs_stringMonthDay;
- (NSString *)fs_stringYearMonthDay;
- (NSString *)fs_stringYearMonthDayHourMinuteSecond;
+ (NSString *)fs_stringYearMonthDayWithDate:(NSDate *)date;      //date为空时返回的是当前年月日
+ (NSString *)fs_stringLocalDate;

#pragma mark - Date formate
+ (NSString *)fs_dateFormatString;
+ (NSString *)fs_timeFormatString;
+ (NSString *)fs_timestampFormatString;
+ (NSString *)fs_timestampFormatStringSubSeconds;

#pragma mark - Date adjust
- (NSDate *)fs_dateByAddingDays: (NSInteger)dDays;
- (NSDate *)fs_dateBySubtractingDays: (NSInteger)dDays;

#pragma mark - Relative dates from the date
+ (NSDate *)fs_dateTomorrow;
+ (NSDate *)fs_dateToday;
+ (NSDate *)fs_dateYesterday;
+ (NSDate *)fs_dateWithDaysFromNow: (NSInteger)days;
+ (NSDate *)fs_dateWithDaysBeforeNow: (NSInteger)days;
+ (NSDate *)fs_dateWithHoursFromNow: (NSInteger)dHours;
+ (NSDate *)fs_dateWithHoursBeforeNow: (NSInteger)dHours;
+ (NSDate *)fs_dateWithMinutesFromNow: (NSInteger)dMinutes;
+ (NSDate *)fs_dateWithMinutesBeforeNow: (NSInteger)dMinutes;
/// 标准格式的零点日期
+ (NSDate *)fs_dateStandardFormatTimeZeroWithDate: (NSDate *)aDate;
/// 负数为过去，正数为未来
- (NSInteger)fs_daysBetweenCurrentDateAndDate;

#pragma mark - Date compare
- (BOOL)fs_isEqualToDateIgnoringTime: (NSDate *)aDate;
/// 返回“今天”，“明天”，“昨天”，或年月日
- (NSString *)fs_stringYearMonthDayCompareToday;

#pragma mark - Date and string convert
+ (NSDate *)fs_dateFromString:(NSString *)string;
+ (NSDate *)fs_dateFromString:(NSString *)string withFormat:(NSString *)format;
- (NSString *)fs_string;
- (NSString *)fs_stringCutSeconds;

@end


@interface FSInterval : NSObject
/** 天 */
@property(nonatomic, assign) NSInteger day;
/** 小时 */
@property(nonatomic, assign) NSInteger hour;
/** 分钟 */
@property(nonatomic, assign) NSInteger minute;
/** 秒 */
@property(nonatomic, assign) NSInteger second;
@end

@interface NSDate (FSInterval)

- (FSInterval *)fs_intervalSinceDate:(NSDate *)date;
- (void)fs_intervalSinceDate:(NSDate *)date day:(NSInteger *)dayP hour:(NSInteger *)hourP minute:(NSInteger *)minuteP second:(NSInteger *)secondP;

/// 是否为今天
- (BOOL)fs_isInToday;

/// 是否为昨天
- (BOOL)fs_isInYesterday;

/// 是否为明天
- (BOOL)fs_isInTomorrow;

/// 是否为本周
- (BOOL)fs_isInThisWeek;

/// 是否为本月
- (BOOL)fs_isInThisMonth;

/// 是否为今年
- (BOOL)fs_isInThisYear;
@end
