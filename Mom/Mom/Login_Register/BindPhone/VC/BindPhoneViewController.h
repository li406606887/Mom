//
//  BindPhoneViewController.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ViewBaseController.h"
#import "LoginModel.h"

@interface BindPhoneViewController : ViewBaseController
@property (copy, nonatomic) NSString *wxcode;
@property (copy, nonatomic) NSString *openid;
@property (copy, nonatomic) LoginModel *model;
@end
