//
//  MyRewardViewModel.h
//  Mom
//
//  Created by together on 2018/5/28.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface MyRewardViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getMyRewardCommand;

@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) NSMutableArray *myRewardArray;
@end
