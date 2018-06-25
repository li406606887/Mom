//
//  JaundiceRecordViewModel.h
//  Mom
//
//  Created by together on 2018/5/30.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface JaundiceRecordViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand * getCurrentRecordCommand;
@property (strong, nonatomic) RACSubject *refreshTableSubject;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end
