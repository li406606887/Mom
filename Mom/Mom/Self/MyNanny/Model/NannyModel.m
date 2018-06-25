//
//  NannyModel.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "NannyModel.h"

@implementation NannyModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

- (void)setStartDate:(NSString *)startDate {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [fmt dateFromString:startDate];
    NSDateFormatter *resultFmt = [[NSDateFormatter alloc] init];
    resultFmt.dateFormat = @"yyyy-MM-dd";
    _startDate = [resultFmt stringFromDate:date];
}

- (void)setEndDate:(NSString *)endDate {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [fmt dateFromString:endDate];
    NSDateFormatter *resultFmt = [[NSDateFormatter alloc] init];
    resultFmt.dateFormat = @"yyyy-MM-dd";
    _endDate = [resultFmt stringFromDate:date];
}
@end
