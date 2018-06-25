//
//  QHRequest+Api.m
//  QHTrade
//
//  Created by user on 2017/6/1.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "QHRequest+Api.h"

@implementation QHRequest (Api)

+(QHRequestModel *)deleteDataWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError **)error {
    
    NSString *request_Url = [NSString stringWithFormat:@"%@%@",HostUrlBak,api];
    __block QHRequestModel *model=nil;
    __block NSError *blockError = nil;
    
    [[QHRequest request] DELETE:request_Url
                     parameters:data_dic
                        success:^(QHRequest *request, id response) {
                            if ([[response objectForKey:@"code"] intValue] != 100000) {
                                blockError = (NSError *)@"数据错误";
                            }
                            model = [QHRequestModel mj_objectWithKeyValues:response];
                        } failure:^(QHRequest *request, NSError *error) {
                            blockError = error;
                            if([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"Request failed: unauthorized (401)"]) {
                                NSLog(@"未登录或者被挤掉");
                                [[UserInformation getInformation] cleanUserInfo];
                            }
                        }];
    
    if (blockError != nil) {
        *error = blockError;
    }
    return model;
}

+(QHRequestModel *)postDataWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError **)error{
    
    NSString *request_Url = [NSString stringWithFormat:@"%@%@",HostUrlBak,api];
    __block QHRequestModel *model=nil;
    __block NSError *blockError = nil;
    
    [[QHRequest request] POST:request_Url
                   parameters:data_dic
                      success:^(QHRequest *request, id response) {
                          if ([[response objectForKey:@"code"] intValue] != 100000) {
                              blockError = (NSError *)@"数据错误";
                          }
                          model = [QHRequestModel mj_objectWithKeyValues:response];                      }
                      failure:^(QHRequest *request, NSError *error) {
                          blockError = error;
                          if([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"Request failed: unauthorized (401)"]) {
                              NSLog(@"未登录或者被挤掉");
                              [[UserInformation getInformation] cleanUserInfo];
                          }
                      }];
    if (blockError !=nil) {
        *error = blockError;
    }
    return model;
}



+(QHRequestModel *)getDataWithApi:(NSString *)api withParam:(NSDictionary *)data_dic error:(NSError **)error{
    NSString *request_Url = [NSString stringWithFormat:@"%@%@",HostUrlBak,api];
    __block QHRequestModel *model=nil;
    __block NSError * blockError = nil;
    
    [[QHRequest request] GET:request_Url
                  parameters:data_dic
                     success:^(QHRequest *request, id response) {
                         if ([[response objectForKey:@"code"] intValue] != 100000) {
                             blockError = (NSError *)@"数据错误";
                         }
                         model = [QHRequestModel mj_objectWithKeyValues:response];
                     } failure:^(QHRequest *request, NSError *error) {
                         blockError = error;
                         if([error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"Request failed: unauthorized (401)"]) {
                             NSLog(@"未登录或者被挤掉");
                             [[UserInformation getInformation] cleanUserInfo];
                         }
                     }];
    
    if (blockError !=nil ) {
        *error = blockError;
    }
    return model;
}

+(void)getQiniuTokenSuccess:(void (^)(void))success {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        QHRequestModel * model = [QHRequest getDataWithApi:@"/api/sys/getUpToken" withParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (error == nil) {
                [UserInformation getInformation].qnToken = model.content;
                success();
            }else{
                showMassage(model.desc);
            }
        });
    });
}

+ (void)uploadFileWithData:(NSData *)data success:(void(^)(NSString *key))success fail:(void(^)(void))fail {
    if ([UserInformation getInformation].qnToken) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [[[QNUploadManager alloc] init] putData:data key:[NSUUID UUID].UUIDString token:[UserInformation getInformation].qnToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                hiddenHUD;
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (info.statusCode == 200) {
                        success(key);
                    }else {
                        showMassage(@"请重新选择");
                    }
                });
            } option:nil];
            
        });
    }else {
        [self getQiniuTokenSuccess:^{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[[QNUploadManager alloc] init] putData:data key:[NSUUID UUID].UUIDString token:[UserInformation getInformation].qnToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (info.statusCode == 200) {
                            NSLog(@"上传成功");
                            success(key);
                        }else {
                            showMassage(@"请重新选择");
                        }
                    });
                } option:nil];
                
            });
        }];
    }
}

//判断手机号码格式是否正确

+ (BOOL)valiMobile:(NSString *)mobile {
    if (mobile.length != 11) {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:mobile] == YES)
        || ([regextestcm evaluateWithObject:mobile] == YES)
        || ([regextestct evaluateWithObject:mobile] == YES)
        || ([regextestcu evaluateWithObject:mobile] == YES))
    {
        return YES;
    } else {
        return NO;
    }
}
@end
