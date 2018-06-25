//
//  NSDate+Extension.h
//
//
//  Created by mac on 16/1/10.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  获取当前日期
 */
+(NSString *)getNowDate;
/**
 *  获取当前日期
 */
+(NSString *)getNowDateWithFormatter:(NSString *)forma;
/**
 *  获取前一天日期
 */
+(NSString *)getBeforeDateWithTime:(NSString *)date;
/**
 *  获取后一天日期
 */
+(NSString *)getBehindDateWithTime:(NSString *)date;
/**
 *  是否为今天
 */
+ (BOOL)isTodayWithDate:(NSString *)time;

+(NSString *)changeDateWithdate:(NSString *)date ;

/**
 *  是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  是否为今年
 */
- (BOOL)isThisYear;

/**
 *  返回一个只有年月日的时间
 */
- (NSDate *)dateWithYMD;

/**
 *  获得与当前时间的差距
 */
- (NSDateComponents *)deltaWithNow;
/**
 *  获取发布日期
 */
+(NSString *)getReleaseDate:(NSString *)seconds format:(NSString *)format;
/**
 *  获取发布日期
 */
+(NSString *)changeTheNoticeTime:(NSString *)time;
/**
 *  计算时间相差几天
 */
+ (NSInteger)numberOfDaysWithFromDate:(NSString *)fromDate toDate:(NSString *)toDate;
/**
 *  发表时间格式转换
 */
+ (NSString *)compareCurrentTime:(NSString *)str ;

/**
 *  获取当日号
 */
+ (NSString *)getDay:(NSString *)date;
/**
 *  获取当月号
 */
+ (NSString *)getMonth:(NSString *)date;

@end
