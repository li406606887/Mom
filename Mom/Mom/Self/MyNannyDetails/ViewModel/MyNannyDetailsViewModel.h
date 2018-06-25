//
//  MyNannyDetailsViewModel.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "NannyModel.h"
#import "BabyModel.h"

@interface MyNannyDetailsViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getOrderCommand;

@property (strong, nonatomic) RACSubject *getOrderSuccessSubject;

@property (strong, nonatomic) RACSubject *evaluationSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (strong, nonatomic) NannyModel *model;
@end
