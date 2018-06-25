//
//  DemandViewModel.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "DemandModel.h"

@interface DemandViewModel : BaseViewModel

@property (strong, nonatomic) RACSubject *cellClickSubject;

@property (strong, nonatomic) RACCommand *getCouponsCommand;

@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;
@end
