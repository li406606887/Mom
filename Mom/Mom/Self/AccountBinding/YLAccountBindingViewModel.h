//
//  YLAccountBindingViewModel.h
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"

@interface YLAccountBindingViewModel : BaseViewModel
@property (nonatomic,strong) RACCommand *cancelBindCommand;
@property (nonatomic,strong) RACCommand *getUserDateCommand;
@property (nonatomic,strong) RACSubject *cellClickSubject;
@property (nonatomic,strong) RACSubject *bindSubject;
@property (nonatomic,strong) RACSubject *noBindSubject;
@end
