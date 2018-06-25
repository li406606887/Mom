//
//  MyBabbyViewModel.h
//  Mom
//
//  Created by together on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "BabyModel.h"

@interface MyBabbyViewModel : BaseViewModel

@property (strong, nonatomic) RACCommand *getMyBabyCommand;

@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;
@end
