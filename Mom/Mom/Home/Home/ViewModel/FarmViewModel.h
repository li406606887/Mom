//
//  FarmViewModel.h
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"
#import "FarmModel.h"

@interface FarmViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getInfoCommand;

@property (nonatomic,strong) RACSubject *farmHeadItemClickSubject;

@property (strong, nonatomic) RACSubject *refreshProblemSubject;

@property (nonatomic,strong) RACSubject *refreshScrollUISubject;

@property (nonatomic,strong) RACCommand *joinActivityCommand;

@property (nonatomic,strong) RACSubject *clickTableSubject;

@property (nonatomic,strong) RACSubject *moreTableSubject;

@property (nonatomic,strong) RACSubject *gotoDemandSubject;

@property (strong, nonatomic) RACCommand *getMainCommand;

@property (strong, nonatomic) RACCommand *getDemandCommand;

@property (strong, nonatomic) RACCommand *getCouponsCommand;

@property (strong, nonatomic) RACCommand *getProblemCommand;

@property (nonatomic,strong) NSMutableArray *scrollArray;

@property (nonatomic,strong) NSMutableArray *demandArray;

@property (nonatomic,strong) NSMutableArray *problemArray;

@property (nonatomic,strong) NSMutableArray *couponsArray;

@property (copy, nonatomic) FarmModel *model;
@end
