//
//  PregnancyViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "PregnancyViewModel.h"

@implementation PregnancyViewModel


- (RACSubject *)saveDateSubject {
    if (!_saveDateSubject) {
        _saveDateSubject = [RACSubject subject];
    }
    return _saveDateSubject;
}
@end
