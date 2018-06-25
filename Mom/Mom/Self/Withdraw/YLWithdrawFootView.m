//
//  YLWithdrawFootView.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//
#import "YLWithdrawFootView.h"
#import "YLWithdrawViewModel.h"

@interface YLWithdrawFootView ()
@property (nonatomic,strong) YLWithdrawViewModel *viewModel;
@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) UILabel *topLabel;
@property (nonatomic,strong) UILabel *yLabel;
@property (nonatomic,strong) UITextField *moneyTextfiled;
@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UILabel *balanceLabel;//余
@property (nonatomic,strong) UIButton *rechargeBtn;
@property (nonatomic,strong) UILabel *todayWithDrawLabel;

@end

@implementation YLWithdrawFootView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLWithdrawViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {
    
}
-(void)btnClick {
    if (self.moneyTextfiled.text.length<1) {
        showMassage(@"请输入提现金额");
        return;
    }
    [self.viewModel.drawBtnClickSubject sendNext:self.moneyTextfiled.text];
}
-(void)setUserModel:(UserDataModel *)userModel {
    if (userModel) {
        //drawMoneyDay  balance
        _balanceLabel.text = [NSString stringWithFormat:@"当前余额 %@",userModel.balance];
        _todayWithDrawLabel.text = [NSString stringWithFormat:@"今日可提现%@元",userModel.drawMoneyDay];
    }
}
-(void)setupViews {
    self.backgroundColor = RGB(240, 240, 240);
    
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.topLabel];
    [self.whiteView addSubview:self.yLabel];
    [self.whiteView addSubview:self.moneyTextfiled];
    [self.whiteView addSubview:self.line];
    [self.whiteView addSubview:self.balanceLabel];
    [self addSubview:self.rechargeBtn];
    [self.whiteView addSubview:self.todayWithDrawLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-60);
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.whiteView).offset(15);
        //        make.size.mas_offset(CGSizeMake(100, 16))
        make.width.mas_offset(100);
    }];
    [self.yLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(15);
        make.top.equalTo(self.topLabel.mas_bottom).offset(25);
        //        make.width.mas_offset(15);
    }];
    [self.moneyTextfiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.yLabel);
        make.left.equalTo(self.yLabel.mas_right).offset(10);
        make.right.equalTo(self.whiteView);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.whiteView);
        make.top.equalTo(self.moneyTextfiled.mas_bottom).offset(15);
        make.height.mas_offset(1);
    }];
    [self.balanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.whiteView).offset(16);
        make.top.equalTo(self.line.mas_bottom).offset(7);
        make.right.equalTo(self.whiteView).offset(-100);
    }];
    [self.rechargeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_bottom).offset(10);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_offset(45);
    }];
    [self.todayWithDrawLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.whiteView).offset(-15);
        make.left.equalTo(self.whiteView).offset(100);
        make.top.equalTo(self.line.mas_bottom).offset(7);
    }];
    
    [super updateConstraints];
}
-(UILabel *)todayWithDrawLabel {
    if (!_todayWithDrawLabel) {
        _todayWithDrawLabel = [[UILabel alloc] init];
        _todayWithDrawLabel.font = [UIFont systemFontOfSize:17];
        _todayWithDrawLabel.textColor = RGB(51, 51, 51);
        _todayWithDrawLabel.text = @"今日可提现 元";
        _todayWithDrawLabel.textAlignment = NSTextAlignmentRight;
    }
    return _todayWithDrawLabel;
}
-(UILabel *)balanceLabel {
    if (!_balanceLabel) {
        _balanceLabel = [[UILabel alloc] init];
        _balanceLabel.font = [UIFont systemFontOfSize:17];
        _balanceLabel.textColor = RGB(153, 153, 153);
        _balanceLabel.text = @"当前余额";
    }
    return _balanceLabel;
}
-(UIButton *)rechargeBtn {
    if (!_rechargeBtn) {
        _rechargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rechargeBtn setTitle:@"提现" forState:UIControlStateNormal];
        [_rechargeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _rechargeBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
//        [_rechargeBtn setBackgroundColor:RGB(255, 218, 68) forState:UIControlStateNormal];
        [_rechargeBtn setBackgroundColor:RGB(255, 218, 68)];
        _rechargeBtn.layer.cornerRadius = 5.0f;
        _rechargeBtn.layer.masksToBounds = YES;
        [_rechargeBtn addTarget:self  action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeBtn;
}

-(UITextField *)moneyTextfiled {
    if (!_moneyTextfiled) {
        _moneyTextfiled = [[UITextField alloc] init];
        _moneyTextfiled.textColor = [UIColor blackColor];//46
        _moneyTextfiled.font = [UIFont systemFontOfSize:46];
        NSString *holderText = @"请输入金额";
        NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
        [placeholder addAttribute:NSForegroundColorAttributeName
                            value:RGB(153, 153, 153)
                            range:NSMakeRange(0, holderText.length)];
        [placeholder addAttribute:NSFontAttributeName
                            value:[UIFont systemFontOfSize:15.0f]
                            range:NSMakeRange(0, holderText.length)];
        _moneyTextfiled.attributedPlaceholder = placeholder;
        _moneyTextfiled.borderStyle = UITextBorderStyleNone;
        _moneyTextfiled.backgroundColor =[UIColor whiteColor];
        _moneyTextfiled.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _moneyTextfiled;
}
-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(240, 240, 240);
    }
    return _line;
}
-(UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}
-(UILabel *)yLabel {
    if (!_yLabel) {
        _yLabel = [[UILabel alloc] init];
        _yLabel.font = [UIFont systemFontOfSize:30];
        _yLabel.textColor = RGB(51, 51, 51);
        _yLabel.text = @"¥";
    }
    return _yLabel;
}
-(UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.font = [UIFont systemFontOfSize:17];
        _topLabel.textColor = RGB(51, 51, 51);
        _topLabel.text = @"提现金额";
    }
    return _topLabel;
}
- (YLWithdrawViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLWithdrawViewModel alloc] init];
    }
    return _viewModel;
}



@end
