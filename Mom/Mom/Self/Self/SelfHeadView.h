//
//  SelfHeadView.h
//  FamilyFarm
//
//  Created by user on 2017/10/24.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "SelfViewModel.h"

@interface SelfHeadView : BaseView
@property (strong, nonatomic) UIView *backView;
@property(nonatomic,strong) UIImageView *headIcon;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *phase;
@property(nonatomic,strong) UIButton *modify;
@property(nonatomic,strong) SelfViewModel *viewModel;
@end
