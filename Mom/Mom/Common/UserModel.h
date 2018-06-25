//
//  UserModel.h
//  QHTrade
//
//  Created by user on 2017/8/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
@property(nonatomic,copy) NSString* wechatAccount;
@property(nonatomic,copy) NSString* drawMoney;
@property(nonatomic,copy) NSString* referrerId;
@property(nonatomic,copy) NSString* nickName;
@property(nonatomic,copy) NSString* openid;
@property(nonatomic,copy) NSString* headUrl;
@property(nonatomic,copy) NSString* cityId;
@property(nonatomic,copy) NSString* type;
@property(nonatomic,copy) NSString* userId;
@property(nonatomic,copy) NSString* alipayAccount;
@property(nonatomic,copy) NSString* password;
@property(nonatomic,copy) NSString* balance;
@property(nonatomic,copy) NSString* phone;
@property(nonatomic,copy) NSString* identity;
@property(nonatomic,copy) NSString* idcard;
@property(nonatomic,copy) NSString* name;
@property(nonatomic,copy) NSString* ID;
@property(nonatomic,copy) NSString* payPassword;
@property(nonatomic,copy) NSString* status;
@property(nonatomic,copy) NSString* username;
@property(nonatomic,copy) NSString* cityName;
@property(nonatomic,copy) NSString* age;
@property(nonatomic,copy) NSString *rewardMoney;
@property(nonatomic,copy) NSString *provinceId;
@property(nonatomic,copy) NSString *provinceName;
@property (copy, nonatomic) NSString *isLeisure;
@property (copy, nonatomic) NSString *takecareBabies;
@property (copy, nonatomic) NSString *birthdate;
@property (copy, nonatomic) NSString *jobYear;
- (void)clearUserData ;
@end
