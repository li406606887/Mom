//
//  DemandModel.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemandModel : NSObject
@property (copy, nonatomic) NSString *addr;
@property (copy, nonatomic) NSString *applies;
@property (copy, nonatomic) NSString *babyType;
@property (copy, nonatomic) NSString *costMax;
@property (copy, nonatomic) NSString *costMin;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *dueDate;
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *headUrl;
@property (copy, nonatomic) NSString *joinCount;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *moonAgeMax;
@property (copy, nonatomic) NSString *moonAgeMin;
@property (copy, nonatomic) NSString *moonCityCode;
@property (copy, nonatomic) NSString *moonCityName;
@property (copy, nonatomic) NSString *motherId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *status;//需求的状态，1.正常2暂停3.结束
@property (copy, nonatomic) NSString *viewCount;
@property (copy, nonatomic) NSString *moonAddr;
@property (copy, nonatomic) NSString *moonExp;
@property (copy, nonatomic) NSString *serviceDay;
@end
