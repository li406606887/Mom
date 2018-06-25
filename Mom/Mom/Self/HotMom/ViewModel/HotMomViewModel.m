//
//  HotMomViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "HotMomViewModel.h"

@implementation HotMomViewModel

- (RACSubject *)saveBabySubject {
    if (!_saveBabySubject) {
        _saveBabySubject = [RACSubject subject];
    }
    return _saveBabySubject;
}

@end
