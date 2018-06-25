//
//  ChooseBabyCell.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ChooseBabyCell.h"

@implementation ChooseBabyCell

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
    self.babyName.text = model.name;
    self.birthDate.text = model.babyBirthday;
    self.babyIcon.image = [model.babySex intValue] ==1 ? [UIImage imageNamed:@"self_baby_boy"]:[UIImage imageNamed:@"self_baby_girl"];
}
- (IBAction)btnClick:(id)sender {
    UIButton *button = (UIButton*) sender;
    button.selected = !button.selected;
    if (self.cellClickBlock) {
        self.cellClickBlock(_model);
    }
}

@end
