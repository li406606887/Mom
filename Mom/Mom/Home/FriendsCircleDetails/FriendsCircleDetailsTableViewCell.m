//
//  FriendsCircleDetailsTableViewCell.m
//  FamilyFarm
//
//  Created by user on 2017/10/31.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "FriendsCircleDetailsTableViewCell.h"

@interface FriendsCircleDetailsTableViewCell ()
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *reply;
@end

@implementation FriendsCircleDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupViews {
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.reply];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.contentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.contentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    
    [self.reply mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).with.offset(10);
        make.top.equalTo(self.name.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-100, 20));
    }];
}

-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor greenColor];
    }
    return _icon;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.text = @"哈哈哈";
    }
    return _name;
}

-(UILabel *)reply {
    if (!_reply) {
        _reply = [[UILabel alloc] init];
        _reply.font = [UIFont systemFontOfSize:14];
        _reply.text = @"回复:说啥还是等";
    }
    return _reply;
}

@end
