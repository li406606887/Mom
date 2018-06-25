//
//  GetCouponTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/31.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "GetCouponTableViewCell.h"

@implementation GetCouponTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)getCoupon:(id)sender {
    if (self.receiveBlock) {
        self.receiveBlock(_model);
    }
}

- (void)setModel:(CouponsModel *)model {
    _model = model;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.title.text = model.title;
    self.content.text = model.content;
    self.useDate.text = [@"有效期:"stringByAppendingString:model.validity];
    if ([self.model.status intValue] == 1) {
        [self.promptBtn setTitle:@"已领取" forState:UIControlStateNormal];
        self.userInteractionEnabled = NO;
    }else {
        [self.promptBtn setTitle:@"领取" forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
    }
}
@end
