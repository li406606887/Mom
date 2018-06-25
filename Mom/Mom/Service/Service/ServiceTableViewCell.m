//
//  ServiceTableViewCell.m
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "ServiceTableViewCell.h"

@interface ServiceTableViewCell()
@property(nonatomic,strong) UIImageView *imageDetails;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UIButton *joinBtn;
@end

@implementation ServiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupViews {
    [self.contentView addSubview:self.imageDetails];
    [self.contentView addSubview:self.title];
    [self.contentView addSubview:self.joinBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.imageDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*0.5));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.imageDetails.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-100, 30));
    }];
    
    [self.joinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.imageDetails.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
}

-(UIImageView *)imageDetails {
    if (!_imageDetails) {
        _imageDetails = [[UIImageView alloc] init];
        [_imageDetails setBackgroundColor:[UIColor greenColor]];
    }
    return _imageDetails;
}

-(UIButton *)joinBtn {
    if (!_joinBtn) {
        _joinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_joinBtn setTitle:@"我要报名" forState:UIControlStateNormal];
        [_joinBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_joinBtn setBackgroundColor:[UIColor redColor]];
    }
    return _joinBtn;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        [_title setFont:[UIFont systemFontOfSize:14]];
        _title.text = @"哈哈";
//        _title.textColor = [
    }
    return _title;
}
@end
