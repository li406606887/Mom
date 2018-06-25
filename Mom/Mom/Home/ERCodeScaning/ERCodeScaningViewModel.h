//
//  ERCodeScaningViewModel.h
//  FamilyFarm
//
//  Created by user on 2017/10/25.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"

@interface ERCodeScaningViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *searchCommand;
@property (strong, nonatomic) RACSubject *refreshTableSubject;
@property (strong, nonatomic) RACSubject *failTableSubject;
@end
