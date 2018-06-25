//
//  SelfViewModel.h
//  FamilyFarm
//
//  Created by user on 2017/10/24.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"

@interface SelfViewModel : BaseViewModel
@property(nonatomic,strong) RACSubject *modifyInfoClickSubject;
@property(nonatomic,strong) RACSubject *selfItemClickSubject;
@property(nonatomic,strong) RACSubject *headIconClickSubject;
@property (strong, nonatomic) RACSubject *refreshHeadInfoSubject;
@end
