//
//  WXPayModel.h
//  Mom
//
//  Created by together on 2018/5/31.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WXPayModel : NSObject
@property (copy, nonatomic) NSString *appid;
@property (copy, nonatomic) NSString *noncestr;
@property (copy, nonatomic) NSString *packages;
@property (copy, nonatomic) NSString *partnerid;
@property (copy, nonatomic) NSString *prepayid;
@property (copy, nonatomic) NSString *sign;
@property (copy, nonatomic) NSString *timestamp;
@end
