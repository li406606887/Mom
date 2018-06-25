//
//  UserDataModel.h
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDataModel : NSObject
@property (nonatomic,strong) NSString *alipayAccount;
@property (nonatomic,strong) NSString *balance;
@property (nonatomic,strong) NSString *cityId;
@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *drawMoney;
@property (nonatomic,strong) NSString *drawMoneyDay;
@property (nonatomic,strong) NSString *headUrl;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *idcard;
@property (nonatomic,strong) NSString *identity;
@property (nonatomic,strong) NSString *isBusy;
@property (nonatomic,strong) NSString *modifyDate;

@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *nickName;
@property (nonatomic,strong) NSString *pageNo;
@property (nonatomic,strong) NSString *pageSize;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *payPassword;
@property (nonatomic,strong) NSString *phone;
@property (nonatomic,strong) NSString *referrerId;
@property (nonatomic,strong) NSString *status;
@property (nonatomic,strong) NSString *thirdpartyUserId;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *userId;
@property (nonatomic,strong) NSString *username;
@property (nonatomic,strong) NSString *wechatAccount;

/*

 {
 alipayAccount = "";
 balance = 0;
 cityId = "";
 createDate = "2018-05-24 23:31:27";
 drawMoney = 0;
 drawMoneyDay = 5000;
 headUrl = "";
 id = 21;
 idcard = "";
 identity = 2;
 isBusy = 0;
 modifyDate = "2018-05-24 23:31:27";
 name = "";
 nickName = "";
 pageNo = "";
 pageSize = "";
 password = "";
 payPassword = "";
 phone = 15160717367;
 referrerId = "";
 status = 2;
 thirdpartyUserId = "";
 type = 0;
 userId = "f3f24410-b039-4046-83f9-c490d4794090";
 username = 15160717367;
 wechatAccount = "";
 }
 */

@end
