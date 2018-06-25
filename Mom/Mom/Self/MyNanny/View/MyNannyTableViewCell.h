//
//  MyNannyTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "NannyModel.h"

@interface MyNannyTableViewCell : BaseTableViewCell
@property(nonatomic,strong) UIImageView *headIcon;
@property(nonatomic,strong) UILabel *serviceTime;
@property(nonatomic,strong) UILabel *state;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *phone;
@property(nonatomic,strong) UIButton *endService;
@property(nonatomic,strong) UIButton *payMoney;
@property(nonatomic,strong) UILabel *payStatus;
@property (copy, nonatomic) NannyModel *model;
@property (copy, nonatomic) void(^payClickBlock) (NannyModel *model);
@property (copy, nonatomic) void(^endClickBlock) (NannyModel *model);
@end
