//
//  YLAddBankViewModel.h
//  Mom
//
//  Created by wgz on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface YLAddBankViewModel : BaseViewModel

@property (nonatomic,strong) RACCommand *commitCommand;

@property (nonatomic,strong) RACCommand *bankCardBinCommand;

@end
