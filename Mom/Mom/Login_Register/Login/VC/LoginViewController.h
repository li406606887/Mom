//
//  LoginViewController.h
//  FamilyFarm
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ViewBaseController.h"
#import "WXApi.h"
#import "LoginModel.h"

@interface LoginViewController : ViewBaseController<WXApiDelegate>
@property (copy, nonatomic) void (^releaseBlock) (void);

@end
