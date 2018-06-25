//
//  GetCouponViewModel.h
//  Mom
//
//  Created by together on 2018/5/31.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface GetCouponViewModel : BaseViewModel
@property (strong, nonatomic) RACSubject *cellClickSubject;

@property (strong, nonatomic) RACCommand *getCouponsListCommand;

@property (strong, nonatomic) RACCommand *getCouponsCommand;

@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;
@end
