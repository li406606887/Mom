//
//  PregnancyTableViewCell.m
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "PregnancyTableViewCell.h"

@implementation PregnancyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setupViews {
    [self addSubview:self.title];
    [self addSubview:self.details];
    [self addSubview:self.date];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).with.offset(-10);
        make.left.equalTo(self).with.offset(20);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    
    [self.details mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(10);
        make.left.equalTo(self.title);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    
    [self.date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).with.offset(-10);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    [super updateConstraints];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = RGB(51, 51, 51);
    }
    return _title;
}

- (UILabel *)details {
    if (!_details) {
        _details = [[UILabel alloc] init];
        _details.font = [UIFont systemFontOfSize:12];
        _details.textColor = [UIColor lightGrayColor];
    }
    return _details;
}

-(UILabel *)date {
    if (!_date) {
        _date = [[UILabel alloc] init];
        _date.font = [UIFont systemFontOfSize:12];
        _date.textColor = [UIColor lightGrayColor];
        _date.text = [NSDate getNowDateWithFormatter:@"YYYY年MM月dd日"];
    }
    return _date;
}
@end
