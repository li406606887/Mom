//
//  SearchNannyTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/22.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SearchNannyTableViewCell.h"

@implementation SearchNannyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(InvitationNannyModel *)model {
    _model = model;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.headUrl]];
    self.name.text = model.nickName;
    self.mark.text = [NSString stringWithFormat:@"%@人 带过%@个宝宝",model.cityName,model.takecareBabies];
    self.status.text = [model.isBusy intValue]== 1 ? @"上户中":@"空闲中";
}
@end
