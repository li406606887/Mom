//
//  GroupTableViewCell.h
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "GroupModel.h"

@interface GroupTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UIImageView *headIcon;

@property (strong, nonatomic) UILabel *name;

@property (strong, nonatomic) UILabel *time;

@property (strong, nonatomic) UILabel *content;

@property (strong, nonatomic) UILabel *answerFirst;

@property (strong, nonatomic) UILabel *answerSecond;

@property (strong, nonatomic) UILabel *lookAll;

@property (strong, nonatomic) UIButton *collect;

@property (strong, nonatomic) UIButton *concern;

@property (strong, nonatomic) UIView *topLine;//view分割线

@property (strong, nonatomic) UIView *boomLine;//view分割线

@property (strong, nonatomic) UIView *btnLine;//按钮分割线

@property (strong, nonatomic) GroupModel *model;

@property (copy, nonatomic) void (^btnClickBlock) (int index);
@end
