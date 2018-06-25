//
//  YLCardManageViewModel.h
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface YLCardManageViewModel : BaseViewModel
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) RACCommand *getDataCommand;
@property (nonatomic,strong) RACCommand *removeCommand;

@property(nonatomic,strong)RACSubject *cellClickSubject;

@property (nonatomic,strong) RACSubject *addBtnClickSubject;


@property(nonatomic,strong)RACSubject *refreshUI;

@property(nonatomic,strong)RACSubject *refreshEndSubject;//刷新结束

@end
