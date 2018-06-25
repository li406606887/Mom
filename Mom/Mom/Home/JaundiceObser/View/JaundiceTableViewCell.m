//
//  JaundiceTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/30.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "JaundiceTableViewCell.h"

@implementation JaundiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(JaundiceObserModel *)model {
    _model = model;
    self.date.text = model.createDate;
    self.nannyName.text = model.userName;
    self.babyName.text = model.babyName;
    self.value.text = model.jaundiceValue;
}

@end
