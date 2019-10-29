//
//  NSDate+FS.m
//  BloodSugar
//
//  Created by PeterPan on 13-12-27.
//  Copyright (c) 2013年 shake. All rights reserved.
//

#import "NSDate+FS.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]

#define D_MINUTE 60
#define D_HOUR   3600
#define D_DAY    86400
#define D_WEEK   604800
#define D_YEAR   31556926

@implementation NSDate (FS)

+ (NSDate *)fs_dateWithYear:(NSInteger)year
                      month:(NSInteger)month
                        day:(NSInteger)day
                       hour:(NSInteger)hour
                     minute:(NSInteger)minute
                     second:(NSInteger)second {

    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *systemTimeZone = [NSTimeZone systemTimeZone];
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setCalendar:gregorian];
    [dateComps setYear:year];
    [dateComps setMonth:month];
    [dateComps setDay:day];
    [dateComps setTimeZone:systemTimeZone];
    [dateComps setHour:hour];
    [dateComps setMinute:minute];
    [dateComps setSecond:second];
    return [dateComps date];
}

+ (NSInteger)fs_daysOffsetBetweenStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned int unitFlags = NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:startDate  toDate:endDate  options:0];
    NSInteger days = [comps day];
    return days;
}

+ (NSDate *)fs_dateWithHour:(int)hour minute:(int)minute {
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:now];
    [components setHour:hour];
    [components setMinute:minute];
    NSDate *newDate = [calendar dateFromComponents:components];
    return newDate;
}

#pragma mark - Data component
- (NSInteger)fs_year {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComponents year];
}

- (NSInteger)fs_month {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComponents month];
}

- (NSInteger)fs_day {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:self];
    return [dateComponents day];
}

- (NSInteger)fs_hour {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit  fromDate:self];
    return [dateComponents hour];
}

- (NSInteger)fs_minute {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit  fromDate:self];
    return [dateComponents minute];
}

- (NSInteger)fs_second {
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit  fromDate:self];
    return [dateComponents second];
}

- (NSString *)fs_weekday {
    NSCalendar*calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    
    NSDate *date = [NSDate date];
    comps =[calendar components:(NSWeekCalendarUnit | NSWeekdayCalendarUnit |NSWeekdayOrdinalCalendarUnit)
                       fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”。。。。）
    NSString *week = @"";
    switch (weekday) {
        case 1:
            week = @"星期日";
            break;
        case 2:
            week = @"星期一";
            break;
        case 3:
            week = @"星期二";
            break;
        case 4:
            week = @"星期三";
            break;
        case 5:
            week = @"星期四";
            break;
        case 6:
            week = @"星期五";
            break;
        case 7:
            week = @"星期六";
            break;
            
        default:
            break;
    }
    return week;
}

#pragma mark - Compare

- (BOOL)isToday {
    return [self fs_isToday];
}

- (BOOL)isTomorrow {
    return [self fs_isTomorrow];
}

- (BOOL)isYesterday {
    return [self fs_isYesterday];
}

- (BOOL)fs_isToday {
    return [[NSCalendar currentCalendar] isDateInToday:self];
}

- (BOOL)fs_isYesterday {
    return [[NSCalendar currentCalendar] isDateInYesterday:self];
}

- (BOOL)fs_isTomorrow {
    return [[NSCalendar currentCalendar] isDateInTomorrow:self];
}

/// 两个日期是否是同一天
+ (BOOL)fs_isDate:(NSDate *)date1 inSameDayAsDate:(NSDate *)date2 {
    return [[NSCalendar currentCalendar] isDate:date1 inSameDayAsDate:date2];
}




#pragma mark - Time string
- (NSString *)fs_timeHourMinute {
    return [self fs_timeHourMinuteWithPrefix:NO suffix:NO];
}

- (NSString *)fs_timeHourMinuteWithPrefix {
    return [self fs_timeHourMinuteWithPrefix:YES suffix:NO];
}

- (NSString *)fs_timeHourMinuteWithSuffix {
    return [self fs_timeHourMinuteWithPrefix:NO suffix:YES];
}

- (NSString *)fs_timeHourMinuteWithPrefix:(BOOL)enablePrefix suffix:(BOOL)enableSuffix {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *timeStr = [formatter stringFromDate:self];
    if (enablePrefix) {
        timeStr = [NSString stringWithFormat:@"%@%@", ([self fs_hour] > 12 ? @"下午" : @"上午"), timeStr];
    }
    if (enableSuffix) {
        timeStr = [NSString stringWithFormat:@"%@%@", ([self fs_hour] > 12 ? @"pm" : @"am"), timeStr];
    }
    return timeStr;
}


#pragma mark - Date String
- (NSString *)fs_stringTimeHHmm {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

- (NSString *)fs_stringMonthDay {
    return [NSDate dateMonthDayWithDate:self];
}

- (NSString *)fs_stringYearMonthDay {
    return [NSDate fs_stringYearMonthDayWithDate:self];
}

- (NSString *)fs_stringYearMonthDayHourMinuteSecond {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *str = [formatter stringFromDate:self];
    return str;
}

- (NSString *)fs_stringYearMonthDayCompareToday {
    NSString *str;
    NSInteger chaDay = [self fs_daysBetweenCurrentDateAndDate];
    if (chaDay == 0) {
        str = @"今天";
    }else if (chaDay == 1) {
        str = @"明天";
    }else if (chaDay == -1) {
        str = @"昨天";
    }else{
        str = [self fs_stringYearMonthDay];
    }
    return str;
}

+ (NSString *)fs_stringLocalDate {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [format  setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    NSString *dateStr = [format stringFromDate:localeDate];
    return dateStr;
}

+ (NSString *)fs_stringYearMonthDayWithDate:(NSDate *)date {
    if (date == nil) {
        date = [NSDate date];
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    return str;
}

+ (NSString *)dateMonthDayWithDate:(NSDate *)date {
    if (date == nil) {
        date = [NSDate date];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
  //  [formatter setDateFormat:@"MM.dd"];
    [formatter setDateFormat:@"yyyy-MM-dd"];

    NSString *str = [formatter stringFromDate:date];
    return str;
}


#pragma mark - Date formate

+ (NSString *)fs_dateFormatString {
	return @"yyyy-MM-dd";
}

+ (NSString *)fs_timeFormatString {
	return @"HH:mm:ss";
}

+ (NSString *)fs_timestampFormatString {
	return @"yyyy-MM-dd HH:mm:ss";
}

+ (NSString *)fs_timestampFormatStringSubSeconds {
    return @"yyyy-MM-dd HH:mm";
}

#pragma mark - Date adjust
- (NSDate *)fs_dateByAddingDays: (NSInteger)dDays {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + D_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)fs_dateBySubtractingDays: (NSInteger)dDays {
    return [self fs_dateByAddingDays:(dDays * -1)];
}

#pragma mark - Relative Dates
+ (NSDate *)fs_dateWithDaysFromNow: (NSInteger) days {
    return [[NSDate date] fs_dateByAddingDays:days];
}

+ (NSDate *)fs_dateWithDaysBeforeNow: (NSInteger) days {
    return [[NSDate date] fs_dateBySubtractingDays:days];
}

+ (NSDate *)fs_dateTomorrow {
    return [NSDate fs_dateWithDaysFromNow:1];
}

+ (NSDate *)fs_dateToday {
    return [NSDate fs_dateWithDaysFromNow:0];
}

+ (NSDate *)fs_dateYesterday {
    return [NSDate fs_dateWithDaysBeforeNow:1];
}

+ (NSDate *)fs_dateWithHoursFromNow: (NSInteger)dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)fs_dateWithHoursBeforeNow: (NSInteger)dHours {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)fs_dateWithMinutesFromNow: (NSInteger)dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)fs_dateWithMinutesBeforeNow: (NSInteger)dMinutes {
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - D_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}


- (BOOL)fs_isEqualToDateIgnoringTime: (NSDate *)aDate {
    NSDateComponents *components1 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:aDate];
    return ((components1.year == components2.year)&&
            (components1.month == components2.month)&&
            (components1.day == components2.day));
}


+ (NSDate *)fs_dateStandardFormatTimeZeroWithDate: (NSDate *)aDate{
    NSString *str = [[NSDate fs_stringYearMonthDayWithDate:aDate] stringByAppendingString:@" 00:00:00"];
    NSDate *date = [NSDate fs_dateFromString:str];
    return date;
}

- (NSInteger)fs_daysBetweenCurrentDateAndDate {
    //只取年月日比较
    NSDate *dateSelf = [NSDate fs_dateStandardFormatTimeZeroWithDate:self];
    NSTimeInterval timeInterval = [dateSelf timeIntervalSince1970];
    NSDate *dateNow = [NSDate fs_dateStandardFormatTimeZeroWithDate:nil];
    NSTimeInterval timeIntervalNow = [dateNow timeIntervalSince1970];
    
    NSTimeInterval cha = timeInterval - timeIntervalNow;
    CGFloat chaDay = cha / 86400.0;
    NSInteger day = chaDay * 1;
    return day;
}

#pragma mark - Date and string convert
+ (NSDate *)fs_dateFromString:(NSString *)string {
    return [NSDate fs_dateFromString:string withFormat:[NSDate dbFormatString]];
}

+ (NSDate *)fs_dateFromString:(NSString *)string withFormat:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    NSDate *date = [inputFormatter dateFromString:string];
    return date;
}

- (NSString *)fs_string {
    return [self stringWithFormat:[NSDate dbFormatString]];
}

- (NSString *)fs_stringCutSeconds {
    return [self stringWithFormat:[NSDate fs_timestampFormatStringSubSeconds]];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    NSString *timestamp_str = [outputFormatter stringFromDate:self];
    return timestamp_str;
}

+ (NSString *)dbFormatString {
    return [NSDate fs_timestampFormatString];
}
@end
