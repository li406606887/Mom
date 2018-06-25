//
//  SelfHeadView.m
//  FamilyFarm
//
//  Created by user on 2017/10/24.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "SelfHeadView.h"

@implementation SelfHeadView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (SelfViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.backView];
    [self.backView addSubview:self.name];
    [self.backView addSubview:self.phase];
    [self.backView addSubview:self.modify];
    [self.backView addSubview:self.headIcon];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backView).with.offset(5);
        make.left.equalTo(self.backView).with.offset(15);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headIcon).with.offset(10);
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.size.mas_offset(CGSizeMake(200, 17));
    }];
    
    [self.phase mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.name.mas_bottom).with.offset(6);
        make.left.equalTo(self.name.mas_left);
        make.size.mas_offset(CGSizeMake(150, 20));
    }];
    
    [self.modify mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self.headIcon);
        make.size.mas_offset(CGSizeMake(70, 20));
    }];
    
    [super updateConstraints];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshHeadInfoSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.name.text = [UserInformation getInformation].userModel.nickName;
        if ([[UserInformation getInformation].userModel.identity intValue] == 1) {
            self.phase.text = [NSString stringWithFormat:@"人生阶段:我在备孕"];
        }else if([[UserInformation getInformation].userModel.identity intValue] == 2) {
            self.phase.text = [NSString stringWithFormat:@"人生阶段:我怀孕了"];
        }else {
            self.phase.text = [NSString stringWithFormat:@"人生阶段:我是辣妈"];
        }
         [self.headIcon sd_setImageWithURL:[NSURL URLWithString:[UserInformation getInformation].userModel.headUrl] placeholderImage:[UIImage imageNamed:@"monther_default_icon"]];
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:16];
        _name.text = [UserInformation getInformation].userModel.nickName;
    }
    return _name;
}

-(UILabel *)phase {
    if (!_phase) {
        _phase = [[UILabel alloc] init];
        _phase.font = [UIFont systemFontOfSize:13];
        if ([[UserInformation getInformation].userModel.identity intValue] == 1) {
            _phase.text = [NSString stringWithFormat:@"人生阶段:我在备孕"];
        }else if([[UserInformation getInformation].userModel.identity intValue] == 2) {
            _phase.text = [NSString stringWithFormat:@"人生阶段:我怀孕了"];
        }else {
            _phase.text = [NSString stringWithFormat:@"人生阶段:我是辣妈"];
        }
        _phase.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        @weakify(self)
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            [self.viewModel.headIconClickSubject sendNext:nil];
        }];
        [_phase addGestureRecognizer:tap];
    }
    return _phase;
}

-(UIButton *)modify {
    if (!_modify) {
        _modify = [UIButton buttonWithType:UIButtonTypeCustom];
        [_modify setTitle:@"个人信息" forState:UIControlStateNormal];
        [_modify.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_modify setBackgroundColor:[UIColor whiteColor]];
        [_modify setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _modify.layer.cornerRadius = 10;
        _modify.layer.masksToBounds = YES;
        @weakify(self)
        [[_modify rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.modifyInfoClickSubject sendNext:nil];
        }];
    }
    return _modify;
}

- (UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        _headIcon.layer.cornerRadius = 30;
        _headIcon.layer.masksToBounds = YES;
        _headIcon.backgroundColor = [UIColor whiteColor];
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:[UserInformation getInformation].userModel.headUrl] placeholderImage:[UIImage imageNamed:@"monther_default_icon"]];
    }
    return _headIcon;
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = RGB(255, 217, 68);
    }
    return _backView;
}
@end
