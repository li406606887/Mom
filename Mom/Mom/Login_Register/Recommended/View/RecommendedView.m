//
//  RecommendedView.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "RecommendedView.h"

@implementation RecommendedView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (RecommendedViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}

- (void)setupViews {
    [self addSubview:self.recommendedPeople];
    [self addSubview:self.passBtn];
    [self addSubview:self.sureBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    [super updateConstraints];
    [self.recommendedPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(30);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
    
    [self.passBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self.recommendedPeople.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-40)/2, 44));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self.recommendedPeople.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake((SCREEN_WIDTH-40)/2, 44));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(UITextField *)recommendedPeople {
    if (!_recommendedPeople) {
        _recommendedPeople = [[UITextField alloc] init];
        _recommendedPeople.font = [UIFont systemFontOfSize:14];
        _recommendedPeople.placeholder = @"请输入推荐人手机号";
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:RGB(150, 150, 150)];
        [line setFrame:CGRectMake(0, 40, SCREEN_WIDTH-50, 0.5)];
        [_recommendedPeople addSubview:line];
        return _recommendedPeople;
    }
    return _recommendedPeople;
}

-(UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:RGB(255, 212, 60)];
        [_sureBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        @weakify(self)
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if ([self.recommendedPeople.text isEqualToString:@""]) {
                showMassage(@"请输入手机号")
                return ;
            }
            if ([QHRequest valiMobile:self.recommendedPeople.text] == NO) {
                showMassage(@"请输入正确的手机号")
                return ;
            }
            NSDictionary *param = @{@"referrer":self.recommendedPeople.text};
            [self.viewModel.bindReferrerCommand execute:param];
        }];
    }
    return _sureBtn;
}

-(UIButton *)passBtn {
    if (!_passBtn) {
        _passBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_passBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [_passBtn setBackgroundColor:[UIColor whiteColor]];
        [_passBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        _passBtn.layer.masksToBounds = YES;
        _passBtn.layer.cornerRadius = 3;
        @weakify(self)
        [[_passBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            [self.viewModel.bindReferrerSubject sendNext:nil];
        }];
    }
    return _passBtn;
}

@end
