//
//  InformationViewModel.h
//  FamilyFarm
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"

@interface InformationViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *setIdentityCommand;

@property (strong, nonatomic) RACSubject *setIdentitySubject;

@property (assign, nonatomic) int state;//1是备孕 2是怀孕 3是辣妈
@end
