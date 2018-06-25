//
//  AddBabyTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "AddBabyTableViewCell.h"

@implementation AddBabyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.field];
}

- (void)layoutSubviews {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(80, 20));
    }];
    
    [self.field mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.height.offset(30);
    }];
    [super layoutSubviews];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont systemFontOfSize:13]];
    }
    return _titleLabel;
}

- (UITextField *)field {
    if (!_field) {
        _field = [[UITextField alloc] init];
        _field.font = [UIFont systemFontOfSize:13];
        _field.textAlignment = NSTextAlignmentCenter;
    }
    return _field;
}
@end
