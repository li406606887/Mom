//
//  YLBalanceDetailsViewModel.h
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface YLBalanceDetailsViewModel : BaseViewModel

@property (nonatomic,strong) NSMutableArray *allDataArray;
@property (nonatomic,strong) NSMutableArray *inDataArray;
@property (nonatomic,strong) NSMutableArray *outDataArray;

@property (nonatomic,strong) RACCommand *getDateCommand;
@property (nonatomic,strong) RACCommand *getInDateCommand;
@property (nonatomic,strong) RACCommand *getOutDateCommand;

@property(nonatomic,strong)RACSubject *refreshUI;

@property(nonatomic,strong)RACSubject *refreshEndSubject;//刷新结束
@end
