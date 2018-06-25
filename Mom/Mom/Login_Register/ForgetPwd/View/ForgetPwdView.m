//
//  ForgetPwdView.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ForgetPwdView.h"

@implementation ForgetPwdView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    _viewModel = (ForgetPwdViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.phoneField];
    [self addSubview:self.newPwdField];
    [self addSubview:self.verificationField];
    [self addSubview:self.sureBtn];
    [self addSubview:self.agreement];
    [self addSubview:self.question];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(30);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
    
    [self.newPwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.phoneField.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
    
    [self.verificationField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.newPwdField.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
    
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.verificationField.mas_bottom).with.offset(30);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
    
    [self.agreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sureBtn.mas_left);
        make.top.equalTo(self.sureBtn.mas_bottom).with.offset(15);
        make.size.mas_offset(CGSizeMake(140, 44));
    }];
    
    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.sureBtn.mas_right);
        make.centerY.equalTo(self.agreement);
        make.size.mas_offset(CGSizeMake(90, 38));
    }];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getCodeSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self addTimer];
    }];
}
- (void)addTimer {
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(refreshLabelText) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)refreshLabelText {
    self.secondsCount++;
    if (self.secondsCount== 60) {
        [self removeTimer];
        self.verificationBtn.text = @"获取验证码";
        self.verificationBtn.userInteractionEnabled = YES;
    } else {
        self.verificationBtn.text = [NSString stringWithFormat:@"%d秒",self.secondsCount];
        self.verificationBtn.userInteractionEnabled = NO;
    }
}

- (void)removeTimer {
    [_timer invalidate];
    self.secondsCount = 0;
    _timer = nil;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UITextField *)phoneField {
    if (!_phoneField) {
        _phoneField = [self creatTextFieldWithPlaceholder:@"手机号"];
    }
    return _phoneField;
}

- (UITextField *)newPwdField {
    if (!_newPwdField) {
        _newPwdField = [self creatTextFieldWithPlaceholder:@"新密码(6-20位数字与字母组合)"];
        _newPwdField.secureTextEntry = YES;
        _newPwdField.rightView = self.isVisible;
        _newPwdField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _newPwdField;
}

- (UITextField *)verificationField {
    if (!_verificationField) {
        _verificationField = [self creatTextFieldWithPlaceholder:@"验证码"];
        _verificationField.rightView = self.verificationBtn;
        _verificationField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _verificationField;
}

- (UIButton *)isVisible {
    if (!_isVisible) {
        _isVisible = [UIButton buttonWithType:UIButtonTypeCustom];
        [_isVisible setFrame:CGRectMake(0, 0, 50, 44)];
        [_isVisible setImage:Image(@"Login_Eye_Hidden") forState:UIControlStateNormal];
        [_isVisible setImage:Image(@"Login_Eye_Hidden_Selected") forState:UIControlStateSelected];
        @weakify(self)
        [[_isVisible rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.newPwdField.secureTextEntry = x.selected;
            x.selected = !x.selected;
        }];
    }
    return _isVisible;
}

- (UILabel *)verificationBtn {
    if (!_verificationBtn) {
        _verificationBtn = [[UILabel alloc] init];
        [_verificationBtn setFrame:CGRectMake(0, 0, 70, 30)];
        _verificationBtn.font =[UIFont systemFontOfSize:12];
        _verificationBtn.text = @"获取验证码";
        _verificationBtn.textColor = RGB(51, 51, 51);
        _verificationBtn.textAlignment = NSTextAlignmentRight;
        _verificationBtn.userInteractionEnabled = YES;
        @weakify(self)
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            if ([self.phoneField.text isEqualToString:@""]) {
                showMassage(@"请输入手机号")
                return ;
            }
            if ([QHRequest valiMobile:self.phoneField.text] == NO) {
                showMassage(@"请输入正确的手机号")
                return ;
            }
          
            [self.viewModel.getCodeCommand execute:@{@"phone":self.phoneField.text,@"type":@"3"}];
        }];
        [_verificationBtn addGestureRecognizer:tap];
    }
    return _verificationBtn;
}

- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"确定重置密码" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:RGB(254, 211, 54)];
        [_sureBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 5;
        @weakify(self)
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if ([self.phoneField.text isEqualToString:@""]) {
                showMassage(@"请输入手机号")
                return ;
            }
            if ([QHRequest valiMobile:self.phoneField.text] == NO) {
                showMassage(@"请输入正确的手机号")
                return ;
            }
            if (self.verificationField.text.length < 1) {
                showMassage(@"请输入验证码")
                return ;
            }
            if(self.newPwdField.text.length<6) {
                showMassage(@"请输入6-20位数字与字母组合的密码")
                return ;
            }
            NSDictionary *param = @{@"phone":self.phoneField.text,@"password":self.newPwdField.text,@"code":self.verificationField.text};
            [self.viewModel.resetPwdCommand execute:param];
        }];
    }
    return _sureBtn;
}


- (UIButton *)question {
    if (!_question) {
        _question = [UIButton buttonWithType:UIButtonTypeCustom];
        [_question setTitle:@"登录遇到问题!" forState:UIControlStateNormal];
        [_question.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_question setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [[_question rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"312");
        }];
    }
    return _question;
}

- (UIButton *)agreement {
    if (!_agreement) {
        _agreement = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreement setImage:[UIImage imageNamed:@"Login_Agreement"] forState:UIControlStateNormal];
        [_agreement setTitle:@"用户协议及隐私政策" forState:UIControlStateNormal];
        [_agreement setTitleColor:RGB(188, 188, 188) forState:UIControlStateNormal];
        [_agreement.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _agreement.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        [[_agreement rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"用户协议");
            [self.viewModel.agreementSubject sendNext:nil];
        }];
    }
    return _agreement;
}


- (UITextField *)creatTextFieldWithPlaceholder:(NSString *)string {
    UITextField *textfield = [[UITextField alloc] init];
    textfield.font = [UIFont systemFontOfSize:14];
    textfield.placeholder = string;
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:RGB(150, 150, 150)];
    [line setFrame:CGRectMake(0, 40, SCREEN_WIDTH-30, 0.5)];
    [textfield addSubview:line];
    return textfield;
}
@end
