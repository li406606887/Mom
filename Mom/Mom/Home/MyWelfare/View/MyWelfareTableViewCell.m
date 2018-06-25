//
//  MyWelfareTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyWelfareTableViewCell.h"

@implementation MyWelfareTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(MyWelfareModel *)model {
    self.title.text = model.title;
    self.content.text = model.content;
}
@end
