//
//  MoreActivityViewModel.h
//  Mom
//
//  Created by together on 2018/6/7.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "FarmModel.h"

@interface MoreActivityViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getProblemCommand;

@property (nonatomic,strong) NSMutableArray *problemArray;

@property (copy, nonatomic) FarmModel *model;

@property (strong, nonatomic) RACSubject *refreshProblemSubject;

@property (nonatomic,strong) RACCommand *joinActivityCommand;

@property (nonatomic,strong) RACSubject *clickTableSubject;
@end
