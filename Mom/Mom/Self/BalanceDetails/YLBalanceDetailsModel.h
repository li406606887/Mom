//
//  YLBalanceDetailsModel.h
//  Mom
//
//  Created by wgz on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLBalanceDetailsModel : NSObject
@property (nonatomic,strong) NSString *auditRemark;
@property (nonatomic,strong) NSString *auditTime;
@property (nonatomic,strong) NSString *auditUser;
@property (nonatomic,strong) NSString *content;
@property (nonatomic,strong) NSString *createDate;
@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *money;
@property (nonatomic,strong) NSString *remark;
@property (nonatomic,strong) NSString *state;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *type;
@property (nonatomic,strong) NSString *userId;

/*
 auditRemark = "<null>";
 auditTime = "<null>";
 auditUser = "<null>";
 content = "\U5e73\U53f0\U5956\U52b1";
 createDate = "2018-04-26 16:26:02";
 id = 2;
 modifyDate = "2018-04-26 16:26:04";
 money = 100;
 remark = "<null>";
 state = 1;
 title = "\U5e73\U53f0\U5956\U52b1";
 type = 1;
 userId = "f5d584c0-9016-4b9e-8706-8d66e2fc33b8";
 */
@end
