//
//  LoginModel.h
//  FamilyFarm
//
//  Created by together on 2018/4/21.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginModel : NSObject
@property (copy, nonatomic) NSString *expiresTime;
@property (copy, nonatomic) NSString *loginTime;
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) NSString *referrerId;
@property (copy, nonatomic) NSString *token;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userStatus;
@property (copy, nonatomic) NSString *userType;
@property (copy, nonatomic) NSString *phone;
@property (copy, nonatomic) NSString *thirdpartyUserId;
@property (copy, nonatomic) NSString *wxOpenid;
@property (copy, nonatomic) NSString *xOpenid;
- (void)clearUserData;
@end
