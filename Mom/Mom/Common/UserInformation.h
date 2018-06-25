//
//  UserInformation.h
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
#import "LoginModel.h"

@interface UserInformation : NSObject
@property(nonatomic,strong) UserModel *userModel;
@property(nonatomic,strong) LoginModel *loginModel;
@property (copy, nonatomic) NSString *qnToken;

+(UserInformation*)getInformation;
//转bsae64方法
+ (NSString *)transBase64WithImage:(UIImage *)image;

-(NSMutableDictionary *)getUserInformationData;
-(void)cleanUserInfo;
//获取七牛token
+(void)requestQiniuToken;
//存七牛token
-(void)setQiniuToken:(NSString *)qiniuToken andLink:(NSString*)link;
//取七牛token
-(NSMutableDictionary *)getQiniuTokenData;
//登录状态
-(BOOL)getLoginState;
//图片上传随机key
- (NSString *)arc4randomForKey;

+ (BOOL)isMobileNumber:(NSString *)mobileNum;

-(void)PostUserInformationDataWithUserId:(NSString *)userid andtoken:(NSString*)token andPhoneNumber:(NSString *)phoneNumber;
@end
