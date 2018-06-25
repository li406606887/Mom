//
//  RecommendedViewModel.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"

@interface RecommendedViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *bindReferrerCommand;

@property (strong, nonatomic) RACSubject *bindReferrerSubject;

@end
