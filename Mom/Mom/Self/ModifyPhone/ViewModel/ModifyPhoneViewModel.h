//
//  ModifyPhoneViewModel.h
//  Mom
//
//  Created by together on 2018/6/8.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface ModifyPhoneViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *rebindingPhoneCommand;

@property (strong, nonatomic) RACSubject *rebindingPhoneSubject;

@property (strong, nonatomic) RACCommand *getCodeCommand;

@property (strong, nonatomic) RACSubject *getCodeSubject;

@property (copy, nonatomic) NSString *wxcode;

@property (copy, nonatomic) NSString *openId;
@end
