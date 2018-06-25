//
//  MyInformationViewModel.h
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"
#import "ProvinceModel.h"

@interface MyInformationViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getInfoCommand;

@property (strong, nonatomic) RACCommand *getProvinceCommand;

@property (strong, nonatomic) RACCommand *getCityCommand;

@property (strong, nonatomic) RACCommand *saveInfoCommand;

@property (strong, nonatomic) RACSubject *saveSuccessSubject;

@property (strong, nonatomic) RACSubject *getProvinceSubject;

@property (strong, nonatomic) RACSubject *chooseHeadIconSubject;

@property (assign, nonatomic) int chooseIndex;

@property (copy, nonatomic) NSString *parentId;

@property (copy, nonatomic) NSString *cityId;


@property (copy, nonatomic) NSMutableArray *provinceArray;

@property (copy, nonatomic) NSMutableArray *cityArray;
@end
