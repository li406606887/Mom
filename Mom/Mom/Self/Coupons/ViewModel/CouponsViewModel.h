//
//  CouponsViewModel.h
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "CouponsModel.h"

@interface CouponsViewModel : BaseViewModel

@property (strong, nonatomic) RACSubject *cellClickSubject;

@property (strong, nonatomic) RACCommand *getCouponsCommand;


@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;
@end
