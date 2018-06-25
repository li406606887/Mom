
//
//  LoginModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/21.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"userName":@"username"};
}

- (void)setToken:(NSString *)token {
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
}

- (void)setExpiresTime:(NSString *)expiresTime {

    [[NSUserDefaults standardUserDefaults] setObject:expiresTime forKey:@"expiresTime"];
}

- (void)setUserId:(NSString *)userId {
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
}

- (void)setUserName:(NSString *)userName {
    [[NSUserDefaults standardUserDefaults] setObject:userName forKey:@"userName"];
}

- (void)setOpenid:(NSString *)openid {
    [[NSUserDefaults standardUserDefaults] setObject:openid forKey:@"openid"];
}

- (void)setReferrerId:(NSString *)referrerId {
    [[NSUserDefaults standardUserDefaults] setObject:referrerId forKey:@"referrerId"];
}

- (void)setUserStatus:(NSString *)userStatus {
    [[NSUserDefaults standardUserDefaults] setObject:userStatus forKey:@"userStatus"];
}

- (void)setUserType:(NSString *)userType {
    [[NSUserDefaults standardUserDefaults] setObject:userType forKey:@"userType"];
}

- (void)setPhone:(NSString *)phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
}

- (void)setThirdpartyUserId:(NSString *)thirdpartyUserId {
    [[NSUserDefaults standardUserDefaults] setObject:thirdpartyUserId forKey:@"thirdpartyUserId"];
}

- (void)setWxOpenid:(NSString *)wxOpenid {
    [[NSUserDefaults standardUserDefaults] setObject:wxOpenid forKey:@"wxOpenid"];
}

- (void)setXOpenid:(NSString *)xOpenid {
    [[NSUserDefaults standardUserDefaults] setObject:xOpenid forKey:@"xOpenid"];
}

- (NSString *)token {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

- (NSString *)expiresTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"expiresTime"];
}

- (NSString *)userId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
}

- (NSString *)userName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userName"];
}

- (NSString *)openid {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"openid"];
}

- (NSString *)referrerId {
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"referrerId"];
}

- (NSString *)userStatus {
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"userStatus"];
}

- (NSString *)userType {
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"userType"];
}

- (NSString *)phone {
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}

- (NSString *)thirdpartyUserId {
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"thirdpartyUserId"];
}

- (NSString *)wxOpenid {
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"wxOpenid"];
}

- (NSString *)xOpenid {
   return [[NSUserDefaults standardUserDefaults] objectForKey:@"xOpenid"];
}


- (void)clearUserData {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"token"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"expiresTime"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userName"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"openid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"referrerId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userStatus"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userType"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"thirdpartyUserId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"wxOpenid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"xOpenid"];
}
@end
