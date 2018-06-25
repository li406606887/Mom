//
//  ForgetPwdViewModel.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"

@interface ForgetPwdViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *resetPwdCommand;

@property (strong, nonatomic) RACCommand *getCodeCommand;

@property (strong, nonatomic) RACSubject *getCodeSubject;

@property (strong, nonatomic) RACSubject *agreementSubject;

@property (strong, nonatomic) RACSubject *resetPwdSubject;

//@property (strong, nonatomic) RACSubject *refreshCodeSubject;
@end
