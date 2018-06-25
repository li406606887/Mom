//
//  MyNannyDetailsHeadView.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "MyNannyDetailsViewModel.h"

@interface MyNannyDetailsHeadView : BaseView
@property (strong, nonatomic) UIImageView *headIcon;
@property (strong, nonatomic) UILabel *name;
@property (strong, nonatomic) UILabel *identity;//身份
@property (strong, nonatomic) UILabel *phone;
@property (strong, nonatomic) UILabel *status;
@property (strong, nonatomic) UILabel *serviceTime;
@property (strong, nonatomic) UILabel *serviceDays;
@property (strong, nonatomic) UILabel *payMoneyLabel;
@property (strong, nonatomic) UILabel *money;
@property (strong, nonatomic) MyNannyDetailsViewModel *viewModel;
@end
