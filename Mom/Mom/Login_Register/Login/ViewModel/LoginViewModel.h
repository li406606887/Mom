//
//  LoginViewModel.h
//  FamilyFarm
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"
#import "LoginModel.h"

@interface LoginViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *loginCommand;
@property (strong, nonatomic) RACCommand *getLoginCodeCommand;
@property (strong, nonatomic) RACCommand *getWXIDCommand;
@property (strong, nonatomic) RACCommand *getInfoCommand;
@property (strong, nonatomic) RACSubject *verificationSubject;
@property (strong, nonatomic) RACSubject *loginSubject;
@property (strong, nonatomic) RACSubject *agreementSubject;
@property (strong, nonatomic) RACSubject *pwdLoginSubject;
@property (strong, nonatomic) RACSubject *otherWayLoginSubject;
@property (strong, nonatomic) RACSubject *getWXIDSubject;
@end
