//
//  MyWelfareViewModel.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "MyWelfareModel.h"

@interface MyWelfareViewModel : BaseViewModel

@property (strong, nonatomic) RACCommand *getMyWelfareCommand;

@property (strong, nonatomic) RACSubject *getMyWelfareSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;
@end
