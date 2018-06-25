//
//  YLWithdrawViewModel.h
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface YLWithdrawViewModel : BaseViewModel

@property (nonatomic,strong) RACCommand *drawCommand;


@property (nonatomic,strong) RACSubject *drawBtnClickSubject;

@end
