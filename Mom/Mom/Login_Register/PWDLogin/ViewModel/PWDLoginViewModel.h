//
//  PWDLoginViewModel.h
//  FamilyFarm
//
//  Created by together on 2018/3/31.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"

@interface PWDLoginViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *loginCommand;
@property (strong, nonatomic) RACSubject *loginSubject;
@property (strong, nonatomic) RACSubject *forgetPwdSubject;
@property (strong, nonatomic) RACSubject *agreementSubject;
@end
