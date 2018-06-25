//
//  AddNannyViewModel.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "BabyModel.h"
#import "InvitationNannyModel.h"

@interface AddNannyViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getMayBabyCommand;

@property (strong, nonatomic) RACCommand *addOrderCommand;

@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) RACSubject *addOrderSuccessSubject;

@property (strong, nonatomic) NSMutableArray *babyArray;

@property (copy, nonatomic) InvitationNannyModel *model;
@end
