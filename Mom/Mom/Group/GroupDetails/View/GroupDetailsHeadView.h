//
//  GroupDetailsHeadView.h
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "BaseView.h"
#import "GroupDetailsViewModel.h"

@interface GroupDetailsHeadView : BaseView
@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UIImageView *headIcon;

@property (strong, nonatomic) UILabel *name;

@property (strong, nonatomic) UILabel *time;

@property (strong, nonatomic) UILabel *content;

@property (strong, nonatomic) UIButton *collect;

@property (strong, nonatomic) UIButton *concern;

@property (strong, nonatomic) UIView *boomLine;//view分割线

@property (strong, nonatomic) UIView *btnLine;//按钮分割线

@property (strong, nonatomic) GroupDetailsViewModel *viewModel;
@end
