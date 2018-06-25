//
//  SquareHeadView.h
//  FamilyFarm
//
//  Created by user on 2017/10/24.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "GroupViewModel.h"
#import "GroupBannerView.h"

@interface SquareHeadView : BaseView
@property (strong, nonatomic)  GroupViewModel *viewModel;

@property (strong, nonatomic)  GroupBannerView *logo;

@property (strong, nonatomic)  UILabel *title;

@property (strong, nonatomic)  UIButton *more;
@end
