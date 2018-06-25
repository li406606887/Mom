//
//  MyNannyViewModel.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "NannyModel.h"

@interface MyNannyViewModel : BaseViewModel

@property (strong, nonatomic) RACSubject *cellClickSubject;

@property (strong, nonatomic) RACCommand *getCouponsCommand;

@property (strong, nonatomic) RACCommand *endOrderCommand;

@property (strong, nonatomic) RACCommand *startOrderCommand;

@property (strong, nonatomic) RACCommand *evaluationOrderCommand;

@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) RACSubject *btnClickSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (copy, nonatomic) NannyModel *model;
@end
