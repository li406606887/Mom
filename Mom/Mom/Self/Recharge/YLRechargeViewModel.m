//
//  YLRechargeViewModel.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLRechargeViewModel.h"

@implementation YLRechargeViewModel
-(RACSubject *)rechargeSubject {
    if (!_rechargeSubject) {
        _rechargeSubject = [RACSubject subject];
    }
    return _rechargeSubject;
}
@end
