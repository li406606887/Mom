//
//  GroupDetailsTableViewCell.h
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "AnswerModel.h"

@interface GroupDetailsTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UIImageView *headIcon;

@property (strong, nonatomic) UILabel *name;

@property (strong, nonatomic) UILabel *content;

@property (strong, nonatomic) UILabel *time;

@property (strong, nonatomic) UIView *line;

@property (copy, nonatomic) AnswerModel *model;
@end
