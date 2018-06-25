//
//  UserModel.m
//  QHTrade
//
//  Created by user on 2017/8/12.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{
             @"ID" : @"id",
             };
}

- (void)setWechatAccount:(NSString *)wechatAccount {
    [[NSUserDefaults standardUserDefaults] setObject:wechatAccount forKey:@"wechatAccount"];
}

- (void)setDrawMoney:(NSString *)drawMoney {
    [[NSUserDefaults standardUserDefaults] setObject:drawMoney forKey:@"drawMoney"];
}

- (void)setReferrerId:(NSString *)referrerId {
    [[NSUserDefaults standardUserDefaults] setObject:referrerId forKey:@"referrerId"];
}

- (void)setNickName:(NSString *)nickName {
    [[NSUserDefaults standardUserDefaults] setObject:nickName forKey:@"nickName"];
}

- (void)setUsername:(NSString *)username {
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
}

- (void)setOpenid:(NSString *)openid {
    [[NSUserDefaults standardUserDefaults] setObject:openid forKey:@"openid"];
}

- (void)setHeadUrl:(NSString *)headUrl {
    [[NSUserDefaults standardUserDefaults] setObject:headUrl forKey:@"headUrl"];
}

- (void)setCityId:(NSString *)cityId {
    [[NSUserDefaults standardUserDefaults] setObject:cityId forKey:@"cityId"];
}

- (void)setType:(NSString *)type {
    [[NSUserDefaults standardUserDefaults] setObject:type forKey:@"type"];
}

- (void)setUserId:(NSString *)userId {
    [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
}

- (void)setAlipayAccount:(NSString *)alipayAccount {
    [[NSUserDefaults standardUserDefaults] setObject:alipayAccount forKey:@"alipayAccount"];
}

- (void)setPassword:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:@"password"];
}

- (void)setBalance:(NSString *)balance {
    [[NSUserDefaults standardUserDefaults] setObject:balance forKey:@"balance"];
}

- (void)setPhone:(NSString *)phone {
    [[NSUserDefaults standardUserDefaults] setObject:phone forKey:@"phone"];
}

- (void)setIdentity:(NSString *)identity {
    [[NSUserDefaults standardUserDefaults] setObject:identity forKey:@"identity"];
}

- (void)setIdcard:(NSString *)idcard {
    [[NSUserDefaults standardUserDefaults] setObject:idcard forKey:@"idcard"];
}

- (void)setName:(NSString *)name {
    [[NSUserDefaults standardUserDefaults] setObject:name forKey:@"name"];
}

- (void)setID:(NSString *)ID {
    [[NSUserDefaults standardUserDefaults] setObject:ID forKey:@"ID"];
}

- (void)setPayPassword:(NSString *)payPassword {
    [[NSUserDefaults standardUserDefaults] setObject:payPassword forKey:@"payPassword"];
}

- (void)setCreateDate:(NSString *)createDate {
    [[NSUserDefaults standardUserDefaults] setObject:createDate forKey:@"createDate"];
}

- (void)setStatus:(NSString *)status {
    [[NSUserDefaults standardUserDefaults] setObject:status forKey:@"status"];
}

- (void)setAge:(NSString *)age {
    [[NSUserDefaults standardUserDefaults] setObject:age forKey:@"age"];
    
}

- (void)setCityName:(NSString *)cityName {
    [[NSUserDefaults standardUserDefaults] setObject:cityName forKey:@"cityName"];
    
}

- (void)setRewardMoney:(NSString *)rewardMoney  {
    [[NSUserDefaults standardUserDefaults] setObject:rewardMoney forKey:@"rewardMoney"];
}

- (void)setProvinceName:(NSString *)provinceName {
    [[NSUserDefaults standardUserDefaults] setObject:provinceName forKey:@"provinceName"];
}

- (void)setProvinceId:(NSString *)provinceId {
    [[NSUserDefaults standardUserDefaults] setObject:provinceId forKey:@"provinceId"];
}

-(void)setBirthdate:(NSString *)birthdate {
    [[NSUserDefaults standardUserDefaults] setObject:birthdate forKey:@"birthdate"];
    
}

- (void)setTakecareBabies:(NSString *)takecareBabies {
    [[NSUserDefaults standardUserDefaults] setObject:takecareBabies forKey:@"takecareBabies"];
}

- (void)setJobYear:(NSString *)jobYear {
    [[NSUserDefaults standardUserDefaults] setObject:jobYear forKey:@"jobYear"];
}

- (NSString *)jobYear {
    return  [[NSUserDefaults standardUserDefaults] objectForKey:@"jobYear"];
}

- (NSString *)takecareBabies {
    return  [[NSUserDefaults standardUserDefaults] objectForKey:@"takecareBabies"];
}

- (NSString *)birthdate {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"birthdate"];
}

- (NSString *)wechatAccount {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"wechatAccount"];
}

- (NSString *)drawMoney {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"drawMoney"];
}

- (NSString *)referrerId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"referrerId"];
}

- (NSString *)nickName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
}

- (NSString *)openid {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"openid"];
}

- (NSString *)headUrl {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"headUrl"];
}

- (NSString *)cityId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityId"];
}

- (NSString *)type {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"type"];
}

- (NSString *)userId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
}

- (NSString *)alipayAccount {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"alipayAccount"];
}

- (NSString *)password {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"password"];
}

- (NSString *)balance {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"balance"];
}

- (NSString *)phone {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"phone"];
}

- (NSString *)identity {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"identity"];
}

- (NSString *)idcard {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"idcard"];
}

- (NSString *)name {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"name"];
}

- (NSString *)payPassword {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"payPassword"];
}

- (NSString *)status {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"status"];
}

- (NSString *)username {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

- (NSString *)age {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"age"];
}

- (NSString *)rewardMoney {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"rewardMoney"];
}

- (NSString *)cityName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"cityName"];
}

- (NSString *)provinceName {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"provinceName"];
}

- (NSString *)provinceId {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"provinceId"];
}

- (void)clearUserData {
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"wechatAccount"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"drawMoney"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"referrerId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"nickName"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"openid"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"headUrl"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"cityId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"type"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"alipayAccount"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"balance"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"phone"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"identity"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"idcard"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"name"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"payPassword"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"status"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"ID"];
}


@end
