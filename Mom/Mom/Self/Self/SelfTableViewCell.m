//
//  SelfCollectionViewCell.m
//  FamilyFarm
//
//  Created by user on 2017/10/24.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "SelfTableViewCell.h"


@implementation SelfTableViewCell

-(void)setupViews {
    [self addSubview:self.icon];
    [self addSubview:self.title];
    [self addSubview:self.detailsTitle];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(100, 18));
        make.left.equalTo(self.icon.mas_right).with.offset(15);
        make.top.equalTo(self.icon);
    }];
    
    [self.detailsTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(15);
        make.top.equalTo(self.title.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-75, 18));
    }];
    [super updateConstraints];
}

-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor clearColor];
    }
    return _icon;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.textColor = [UIColor darkGrayColor];
    }
    return _title;
}

- (UILabel *)detailsTitle {
    if (!_detailsTitle) {
        _detailsTitle = [[UILabel alloc] init];
        _detailsTitle.font = [UIFont systemFontOfSize:10];
        _detailsTitle.textColor = [UIColor lightGrayColor];
    }
    return _detailsTitle;
}
@end
