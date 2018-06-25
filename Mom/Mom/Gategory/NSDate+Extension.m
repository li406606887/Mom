//
//  NSDate+Extension.m
//
//
//  Created by mac on 16/1/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
/**
 *  获取当前日期
 */
+(NSString *)getNowDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+(NSString *)getNowDateWithFormatter:(NSString *)forma {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:forma];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    return currentTimeString;
}

+(NSString *)changeDateWithdate:(NSString *)date {
    NSDateFormatter *formBefore = [[NSDateFormatter alloc] init];
    [formBefore setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *time = [formBefore dateFromString:date];
    NSDateFormatter *formEnd = [[NSDateFormatter alloc] init];
    [formEnd setDateFormat:@"YYYY-MM-dd"];
    NSString *newDate = [formEnd stringFromDate:time];
    return newDate;
}
/**
 *  获取前一天日期
 */
+(NSString *)getBeforeDateWithTime:(NSString *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *time = [formatter dateFromString:date];
    
    NSDate *behindDay = [NSDate dateWithTimeInterval:-24*60*60 sinceDate:time];//前一天
    NSString *behindDayString = [formatter stringFromDate:behindDay];
    return behindDayString;
}
/**
 *  获取后一天日期
 */
+(NSString *)getBehindDateWithTime:(NSString *)date {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    NSDate *time = [formatter dateFromString:date];
    
    NSDate *beforeDay = [NSDate dateWithTimeInterval:+24*60*60 sinceDate:time];//前一天
    NSString *lastDayString = [formatter stringFromDate:beforeDay];
    return lastDayString;
}
/**
 *  是否为今天
 */
+ (BOOL)isTodayWithDate:(NSString *)time {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:time];
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

/**
 *  是否为昨天
 */
- (BOOL)isYesterday
{
    // 2014-05-01
    NSDate *nowDate = [[NSDate date] dateWithYMD];
    
    // 2014-04-30
    NSDate *selfDate = [self dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (NSDate *)dateWithYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

/**
 *  是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

- (NSDateComponents *)deltaWithNow
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

+(NSString *)getReleaseDate:(NSString *)seconds format:(NSString *)format{
    
    NSString * astr = [seconds stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/Date()/"]];
    NSString * bstr = [astr substringWithRange:NSMakeRange(0,10)];
    
    NSTimeInterval time  = [bstr doubleValue];//因为时差问题要加8小时 == 28800 sec
    
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:time];
    
    //实例化一个NSDateFormatter对象
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc]init];
    
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    NSString * currentDateStr = [dateFormatter stringFromDate:date];
    
    
    return currentDateStr;
}

+(NSString *)changeTheNoticeTime:(NSString *)time{
    NSDateFormatter * dateFormatter_one = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter_one setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter_one dateFromString:time];
    
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSString *releasetime; //发布时间
    // 当前时间字符串格式
    NSString *nowDateStr = [dateFomatter stringFromDate:nowDate];
    // 截止时间data格式
    NSDate *expireDate = [dateFomatter dateFromString:time];
    // 当前时间data格式
    nowDate = [dateFomatter dateFromString:nowDateStr];
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:0];
    int month = (int)dateCom.month*-1;
    int day = (int)dateCom.day*-1;
    int hour = (int)dateCom.hour*-1;
    int minute = (int)dateCom.minute*-1;
    if (month >0||day >0) {
        NSDateFormatter * dateFormatter_two = [[NSDateFormatter alloc]init];
        [dateFormatter_two setDateFormat:@"MM-dd HH:mm"];
        releasetime = [dateFormatter_two stringFromDate:date];
        return releasetime;
    }else if(hour>0){
        releasetime = [NSString stringWithFormat:@"%d小时前",hour];
        return releasetime;
    }else if(minute>5){
        releasetime = [NSString stringWithFormat:@"%d分钟前",hour];
        return releasetime;
    }else{
        releasetime = @"刚刚";
        return releasetime;
    }
    
}

+ (NSInteger)numberOfDaysWithFromDate:(NSString *)fromDate toDate:(NSString *)toDate{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *beginDate = [dateFormatter dateFromString:fromDate];
    NSDate *endDate = [dateFormatter dateFromString:toDate];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents * comp = [calendar components:NSCalendarUnitDay
                                          fromDate:beginDate
                                            toDate:endDate
                                           options:NSCalendarWrapComponents];
    
    return comp.day;
}

+ (NSString *)getDay:(NSString *)date {
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * days = [dateFomatter dateFromString:date];
    NSDateFormatter *dateFomatter2 = [[NSDateFormatter alloc] init];
    dateFomatter2.dateFormat = @"dd";
    return [dateFomatter2 stringFromDate:days];
}

+ (NSString *)getMonth:(NSString *)date {
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate * days = [dateFomatter dateFromString:date];
    NSDateFormatter *dateFomatter2 = [[NSDateFormatter alloc] init];
    dateFomatter2.dateFormat = @"MM";
    return [dateFomatter2 stringFromDate:days];
}

+ (NSString *)compareCurrentTime:(NSString *)str {
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:str];
    
    //得到与当前时间差
    NSTimeInterval  timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    //标准时间和北京时间差8个小时
    timeInterval = timeInterval - 8*60*60;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%d小时前",temp];
    }
    
    else if((temp = temp/24) <5){
        result = [NSString stringWithFormat:@"%d天前",temp];
    }
    else {
        result = str;
    }
    return  result;
}

@end
