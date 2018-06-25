//
//  TableViewCell.m
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "CouponsTableViewCell.h"

@implementation CouponsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnClick:(id)sender {
    NSLog(@"点击了领取");
}

- (void)setModel:(CouponsModel *)model {
    _model = model;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.title.text = model.title;
    self.content.text = model.content;
    self.useDate.text = [@"有效期:"stringByAppendingString:model.validity];
    self.promptBtn.hidden = YES;
    self.line.hidden = YES;
    if ([NSDate isTodayWithDate:model.endTime]) {
        self.promptBtn.hidden = NO;
        self.line.hidden = NO;
    }
}
@end
