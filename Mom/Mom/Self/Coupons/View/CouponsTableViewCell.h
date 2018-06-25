//
//  CouponsTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "CouponsModel.h"

@interface CouponsTableViewCell : BaseTableViewCell
@property (copy, nonatomic) CouponsModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *useDate;
@property (weak, nonatomic) IBOutlet UIButton *promptBtn;
@property (weak, nonatomic) IBOutlet UIView *line;

@property (copy, nonatomic) void(^receiveBlock) (CouponsModel*model);
@end
