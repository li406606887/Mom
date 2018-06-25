//
//  SendDemandViewModel.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "ProvinceModel.h"

@interface SendDemandViewModel : BaseViewModel

@property (strong, nonatomic) RACCommand *getProvinceCommand;

@property (strong, nonatomic) RACCommand *getCityCommand;

@property (strong, nonatomic) RACCommand *sendDemandCommand;

@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) RACSubject *getProvinceSubject;

@property (assign, nonatomic) int chooseIndex;

@property (copy, nonatomic) NSString *parentId;

@property (copy, nonatomic) NSString *cityId;

@property (copy, nonatomic) NSString *headKey;

@property (copy, nonatomic) NSMutableArray *provinceArray;

@property (copy, nonatomic) NSMutableArray *cityArray;

@end
