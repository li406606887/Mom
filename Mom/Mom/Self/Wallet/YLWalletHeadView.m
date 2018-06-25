//
//  YLWalletHeadView.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//
#import "YLWalletHeadView.h"
#import "YLWalletViewModel.h"
#import "UserDataModel.h"
@interface YLWalletHeadView ()
@property (nonatomic,strong) YLWalletViewModel *viewModel;
@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@end

@implementation YLWalletHeadView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLWalletViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {
    WS(weakSelf)
    [[self.viewModel.balanceSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id   _Nullable x) {
        UserDataModel * model = (UserDataModel *)x;
        weakSelf.moneyLabel.text = [NSString stringWithFormat:@"%@",model.balance];
    }];
}
-(void)setupViews {
    [self addSubview:self.topLabel];
    [self addSubview:self.moneyLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(35);
        make.centerX.equalTo(self);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabel.mas_bottom).offset(20);
        make.centerX.equalTo(self);
    }];
    
    [super updateConstraints];
}
-(UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = [UIFont systemFontOfSize:50];
        _moneyLabel.textColor = RGB(51, 51, 51);
        _moneyLabel.text = @"";
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _moneyLabel;
}
-(UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont systemFontOfSize:15];
        _topLabel.textColor = RGB(51, 51, 51);
        _topLabel.text = @"账户余额(元)";
        _topLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _topLabel;
}
- (YLWalletViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLWalletViewModel alloc] init];
    }
    return _viewModel;
}


@end
