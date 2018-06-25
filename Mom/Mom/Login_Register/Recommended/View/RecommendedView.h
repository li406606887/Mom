//
//  RecommendedView.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "RecommendedViewModel.h"

@interface RecommendedView : BaseView
@property (strong, nonatomic) RecommendedViewModel *viewModel;
@property (strong, nonatomic) UITextField *recommendedPeople;

@property (strong, nonatomic) UIButton *passBtn;

@property (strong, nonatomic) UIButton *sureBtn;
@end
