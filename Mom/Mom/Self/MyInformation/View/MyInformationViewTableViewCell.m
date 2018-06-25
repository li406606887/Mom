//
//  MyInformationViewTableViewCell.m
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "MyInformationViewTableViewCell.h"

@implementation MyInformationViewTableViewCell

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
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    
    [self.details mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-20);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    [super updateConstraints];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textColor = [UIColor darkTextColor];
    }
    return _title;
}

- (UITextField *)details {
    if (!_details) {
        _details = [[UITextField alloc] init];
        _details.font = [UIFont systemFontOfSize:14];
        _details.textColor = RGB(38, 38, 38);
        _details.textAlignment = NSTextAlignmentRight;
    }
    return _details;
}
@end


@implementation MyInformationViewIconTableViewCell

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
    [self addSubview:self.backHeadIcon];
    [self.backHeadIcon addSubview:self.headIcon];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
   
    [self.backHeadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backHeadIcon);
    }];
    
    [super updateConstraints];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textColor = [UIColor darkTextColor];
    }
    return _title;
}

- (UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:[UserInformation getInformation].userModel.headUrl] placeholderImage:[UIImage imageNamed:@"monther_default_icon"]];
    }
    return _headIcon;
}

- (UIImageView *)backHeadIcon {
    if (!_backHeadIcon) {
        _backHeadIcon = [[UIImageView alloc] init];
        _backHeadIcon.layer.cornerRadius = 30;
        _backHeadIcon.layer.masksToBounds = YES;
    }
    return _backHeadIcon;
}
@end
