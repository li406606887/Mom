//
//  YLWalletViewModel.h
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface YLWalletViewModel : BaseViewModel

@property (nonatomic,strong) RACSubject * cellClickSubject;

@property (nonatomic,strong) RACCommand * getDateCommand;
@property (nonatomic,strong) RACSubject * balanceSubject;
@end
