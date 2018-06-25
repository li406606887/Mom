//
//  ModifyLoginPwdViewModel.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"

@interface ModifyLoginPwdViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *modifyPasswordCommand;

@property (strong, nonatomic) RACSubject *modifyPasswordPwdSubject;


@end
