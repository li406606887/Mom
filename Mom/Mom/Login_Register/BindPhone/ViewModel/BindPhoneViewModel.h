//
//  BindPhoneViewModel.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"

@interface BindPhoneViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *rebindingPhoneCommand;

@property (strong, nonatomic) RACSubject *rebindingPhoneSubject;

@property (strong, nonatomic) RACCommand *getCodeCommand;

@property (strong, nonatomic) RACSubject *getCodeSubject;

@property (copy, nonatomic) NSString *wxcode;

@property (copy, nonatomic) NSString *openId;
@end
