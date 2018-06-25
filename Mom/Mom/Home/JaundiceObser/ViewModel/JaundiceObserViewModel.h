//
//  JaundiceObserViewModel.h
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "BabyModel.h"

@interface JaundiceObserViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand * getCreateRecordCommand;
@property (strong, nonatomic) RACCommand * getCurrentDayCommand;
@property (strong, nonatomic) RACCommand * getMyBabyCommand;
@property (strong, nonatomic) RACSubject *refreshTableSubject;
@property (strong, nonatomic) RACSubject *goBackSubject;
@property (strong, nonatomic) NSString * headUrl;
@property (strong, nonatomic) NSString * neckUrl;
@property (strong, nonatomic) NSString * chestPicUrl;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (copy, nonatomic) BabyModel *model;
@end
