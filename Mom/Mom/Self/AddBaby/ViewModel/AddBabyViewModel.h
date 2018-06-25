//
//  AddBabyViewModel.h
//  Mom
//
//  Created by together on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface AddBabyViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *addBabyCommand;

@property (strong, nonatomic) RACCommand *modifyBabyCommand;

@property (strong, nonatomic) RACSubject *addBabySubject;
@end
