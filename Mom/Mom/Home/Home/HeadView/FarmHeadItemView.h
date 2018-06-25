//
//  FarmHeadItemView.h
//  FamilyFarm
//
//  Created by user on 2017/10/19.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "FarmViewModel.h"

@interface FarmHeadItemView : BaseView
@property(nonatomic,strong) FarmViewModel *viewModel;
@property (strong, nonatomic) UIView *backView;
@end
