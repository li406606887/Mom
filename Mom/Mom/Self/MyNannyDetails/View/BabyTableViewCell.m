//
//  BabyTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BabyTableViewCell.h"

@implementation BabyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(BabyModel *)model {
    _model = model;
    self.headIcon.image = [model.babySex intValue] ==1 ? [UIImage imageNamed:@"self_baby_boy"]:[UIImage imageNamed:@"self_baby_girl"];
    self.name.text = model.name;
    self.birthDate.text = [NSString stringWithFormat:@"出生(或预产期):%@",model.babyBirthday];
}

@end
