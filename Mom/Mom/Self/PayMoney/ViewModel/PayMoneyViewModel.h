//
//  PayMoneyViewModel.h
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface PayMoneyViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *onliePayCommand;

@property (strong, nonatomic) RACCommand *outLinePayCommand;

@property (copy, nonatomic) RACSubject *onLinePaySuccessSubject;

@property (copy, nonatomic) RACSubject *outLinePaySuccessSubject;

@end
