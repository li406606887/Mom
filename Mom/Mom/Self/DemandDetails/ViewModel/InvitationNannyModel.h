//
//  InvitationNannyModel.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InvitationNannyModel : NSObject
@property (copy, nonatomic) NSString *headUrl;
@property (copy, nonatomic) NSString *isBusy;//1是上户 0是空闲
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *status;//0  禁用   1 正常   2 待认证  3 待审核  4 认证失败
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *takecareBabies;
@property (copy, nonatomic) NSString *cityName;
@end
