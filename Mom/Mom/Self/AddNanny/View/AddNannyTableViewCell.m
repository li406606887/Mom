//
//  AddNannyTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "AddNannyTableViewCell.h"

@implementation AddNannyTableViewCell

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
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"nanny_default_icon"]];
    self.name.text = model.nickName;
    self.mark.text = [NSString stringWithFormat:@"%@人 带过%@个宝宝",model.cityName,model.takecareBabies];
}
@end
