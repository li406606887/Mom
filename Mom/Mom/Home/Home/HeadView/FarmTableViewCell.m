//
//  FarmTableViewCell.m
//  FamilyFarm
//
//  Created by user on 2017/10/19.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "FarmTableViewCell.h"

@interface FarmTableViewCell()
@property (strong, nonatomic) UIView *backView;
@property(nonatomic,strong) UIImageView *headIcon;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *time;
@property(nonatomic,strong) UILabel *applyQuantity;
@property(nonatomic,strong) UIButton *join;
@end

@implementation FarmTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setupViews {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView addSubview:self.backView];
    [self.contentView addSubview:self.headIcon];
    [self.backView addSubview:self.title];
    [self.backView addSubview:self.time];
    [self.backView addSubview:self.applyQuantity];
    [self.backView addSubview:self.join];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 10, 0));
    }];
    
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(15);
        make.top.equalTo(self.backView).with.offset(10);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headIcon);
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom);
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    [self.applyQuantity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.time.mas_bottom);
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    [self.join mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headIcon);
        make.right.equalTo(self.backView.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
}
- (void)setModel:(FarmModel *)model {
    _model = model;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.url]];
    self.title.text = model.title;
    self.time.text = model.actTime;
    self.applyQuantity.text = [NSString stringWithFormat:@"报名人数:%@",model.applyQuantity];
    NSString *str = [model.status intValue] == 1 ? @"已报名":@"报名";
    [self.join setTitle:str forState:UIControlStateNormal];
}

-(UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
    }
    return _headIcon;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
    }
    return _title;
}

-(UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:14];
        _time.textColor = [UIColor lightGrayColor];
    }
    return _time;
}

-(UILabel *)applyQuantity {
    if (!_applyQuantity) {
        _applyQuantity = [[UILabel alloc] init];
        _applyQuantity.textColor = [UIColor lightGrayColor];
        _applyQuantity.font = [UIFont systemFontOfSize:14];

    }
    return _applyQuantity;
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.masksToBounds = YES;
        _backView.layer.cornerRadius = 3;
    }
    return _backView;
}

- (UIButton *)join {
    if (!_join) {
        _join = [UIButton buttonWithType:UIButtonTypeCustom];
        [_join setTitle:@"" forState:UIControlStateNormal];
        [_join setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_join.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_join setBackgroundColor:RGB(255, 212, 60)];
        _join.layer.masksToBounds = YES;
        _join.layer.cornerRadius = 15;
        @weakify(self)
        [[_join rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if ([self.model.status intValue] == 1 ) {
                return ;
            }
            if (self.btnClickBlock) {
                self.btnClickBlock(self.model);
            }
        }];
    }
    return _join;
}
@end
