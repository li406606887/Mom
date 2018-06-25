//
//  GroupDetailsTableViewCell.m
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "GroupDetailsTableViewCell.h"

@implementation GroupDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    [self addSubview:self.headIcon];
    
    [self addSubview:self.name];
    
    [self addSubview:self.content];
    
    [self addSubview:self.time];
    
    [self addSubview:self.line];
}

- (void)layoutSubviews {
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self.headIcon);
        make.size.mas_offset(CGSizeMake(150, 18));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.centerY.equalTo(self.headIcon);
        make.size.mas_offset(CGSizeMake(120, 18));
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(5);
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.bottom.equalTo(self.mas_bottom).with.offset(10);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 0.4));
    }];
}

- (void)setModel:(AnswerModel *)model {
    _model = model;
    self.time.text = [NSDate compareCurrentTime:model.createDate];
    self.name.text = model.nickName;
    self.content.text = model.content;
    [_headIcon sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"monther_default_icon"]];
}

-(UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        _headIcon.layer.masksToBounds = YES;
        _headIcon.layer.cornerRadius = 20;
    }
    return _headIcon;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.text = @"李奶奶";
        _name.textColor = RGB(200, 200, 200);
    }
    return _name;
}

- (UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = [UIFont systemFontOfSize:14];
        _content.text = @"多休息,多吃清淡食物";
        _content.numberOfLines = 0;
    }
    return _content;
}

- (UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:12];
        _time.textColor = RGB(222, 222, 222);
        _time.textAlignment = NSTextAlignmentRight;
        _time.text = @"17分钟前";
        _time.text = [NSDate compareCurrentTime:_model.createDate];

    }
    return _time;
}

- (UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        [_line setBackgroundColor:RGB(230, 230, 230)];
    }
    return _line;
}
@end
