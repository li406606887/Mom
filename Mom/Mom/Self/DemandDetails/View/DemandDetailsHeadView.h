//
//  DemandDetailsHeadView.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "DemandDetailsViewModel.h"

@interface DemandDetailsHeadView : BaseView
@property (strong, nonatomic) DemandDetailsViewModel *viewModel;
@property (strong, nonatomic)  UIView *backView;
@property (strong, nonatomic)  UIView *lineView;
@property (strong, nonatomic)  UILabel *demandInfo;
@property (strong, nonatomic)  UILabel *markInfo;
@property (strong, nonatomic)  UILabel *browseDetails;

@property (strong, nonatomic) UIButton *suspended;
@property (strong, nonatomic) UIButton *end;
@end
