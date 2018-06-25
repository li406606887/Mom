//
//  MyRewardTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/28.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyRewardTableViewCell.h"

@implementation MyRewardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(MyRewardModel *)model {
    _model = model;
    self.title.text = [NSString stringWithFormat:@"%@",model.title];
    self.time.text = [NSString stringWithFormat:@"%@ %@",model.createDate,model.content];
    self.money.text = [NSString stringWithFormat:@"￥%@",model.money];
}
@end
