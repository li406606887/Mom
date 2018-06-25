//
//  LoginView.m
//  FamilyFarm
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (LoginViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.logo];
    [self addSubview:self.phone];
    [self addSubview:self.pwd];
    [self addSubview:self.login];
    [self addSubview:self.agreement];
    [self addSubview:self.pwdBtn];
    [self addSubview:self.otherLoginWay];
    [self addSubview:self.wxBtn];
//    [self addSubview:self.alipayBtn];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(111, 32));
    }];

    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo.mas_bottom).with.offset(30);
        make.centerX.equalTo(self.logo);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 30));
    }];

    [self.pwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phone.mas_bottom).with.offset(30);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 40));
    }];
    
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.pwd.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 44));
    }];
    
    [self.agreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.login.mas_left);
        make.top.equalTo(self.login.mas_bottom).with.offset(5);
        make.size.mas_offset(CGSizeMake(140, 44));
    }];
    
    [self.pwdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.login.mas_right);
        make.top.equalTo(self.login.mas_bottom).with.offset(5);
        make.size.mas_offset(CGSizeMake(70, 38));
    }];
    
    [self.otherLoginWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_bottom).with.offset(-120);
        make.size.mas_offset(CGSizeMake(150, 20));
    }];
    
//    [self.alipayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.otherLoginWay.mas_bottom).with.offset(15);
//        make.right.equalTo(self.otherLoginWay.mas_right);
//        make.size.mas_offset(CGSizeMake(60, 60));
//    }];
    
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.otherLoginWay.mas_bottom).with.offset(15);
//        make.left.equalTo(self.otherLoginWay.mas_left);
        make.centerX.equalTo(self); 
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    [super updateConstraints];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.verificationSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        __block int i = 0;
        NSTimeInterval time = 1.0;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, time * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            i++;
            if (i==60) {
                dispatch_source_cancel(timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.validationLabel.text = @"发送验证码";
                    self.validationLabel.userInteractionEnabled = YES;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.validationLabel.userInteractionEnabled = NO;
                    self.validationLabel.text = [NSString stringWithFormat:@"%d秒",i];
                });
            }
        });
        dispatch_resume(timer);
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIImageView *)logo {
    if (!_logo) {
        _logo = [[UIImageView alloc] init];
        _logo.image = Image(@"NavigationBar_Logo");
    }
    return _logo;
}

- (UITextField *)phone {
    if (!_phone) {
        _phone = [self creatTextFieldWithPlaceholder:@"手机号"];
    }
    return _phone;
}

- (UITextField *)pwd {
    if (!_pwd) {
        _pwd = [self creatTextFieldWithPlaceholder:@"验证码"];
        _pwd.rightView = self.validationLabel;
        _pwd.rightViewMode = UITextFieldViewModeAlways;
    }
    return _pwd;
}

- (UILabel *)validationLabel {
    if (!_validationLabel) {
        _validationLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 30)];
        _validationLabel.textColor = RGB(51, 51, 51);
        _validationLabel.font = [UIFont systemFontOfSize:12];
        _validationLabel.text = @"发送验证码";
        _validationLabel.userInteractionEnabled=YES;
        _validationLabel.textAlignment = NSTextAlignmentRight;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            if ([self.phone.text isEqualToString:@""]) {
                showMassage(@"请输入手机号")
                return ;
            }
            if ([QHRequest valiMobile:self.phone.text] == NO) {
                showMassage(@"请输入正确的手机号")
                return ;
            }
            NSDictionary *param = @{@"phone":self.phone.text,@"type":@"2"};
            [self.viewModel.getLoginCodeCommand execute:param];
        }];
        [_validationLabel addGestureRecognizer:tap];
    }
    return _validationLabel;
}

- (UIButton *)login {
    if (!_login) {
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        [_login setTitle:@"登  录" forState:UIControlStateNormal];
        [_login setBackgroundColor:RGB(254, 211, 54)];
        [_login setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        @weakify(self)
        [[_login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if ([self.phone.text isEqualToString:@""]) {
                showMassage(@"请输入手机号")
                return ;
            }
            if ([QHRequest valiMobile:self.phone.text] == NO) {
                showMassage(@"请输入正确的手机号")
                return ;
            }
            if (self.pwd.text.length < 1) {
                showMassage(@"请输入验证码")
                return ;
            }
            NSDictionary *param = @{@"phone":self.phone.text,@"code":self.pwd.text};
            [self.viewModel.loginCommand execute:param];
        }];
    }
    return _login;
}

- (UIButton *)agreement {
    if (!_agreement) {
        _agreement = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreement setImage:[UIImage imageNamed:@"Login_Agreement"] forState:UIControlStateNormal];
        [_agreement setTitle:@"用户协议及隐私政策" forState:UIControlStateNormal];
        [_agreement setTitleColor:RGB(188, 188, 188) forState:UIControlStateNormal];
        [_agreement.titleLabel setFont:[UIFont systemFontOfSize:12]];
        _agreement.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
        @weakify(self)
        [[_agreement rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.agreementSubject sendNext:nil];
        }];
    }
    return _agreement;
}

- (UIButton *)pwdBtn {
    if (!_pwdBtn) {
        _pwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pwdBtn setTitle:@"密码登录" forState:UIControlStateNormal];
        [_pwdBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_pwdBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        @weakify(self)
        [[_pwdBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.pwdLoginSubject sendNext:nil];
        }];
    }
    return _pwdBtn;
}

- (UILabel *)otherLoginWay {
    if (!_otherLoginWay) {
        _otherLoginWay = [[UILabel alloc] init];
        _otherLoginWay.font = [UIFont systemFontOfSize:14];
        _otherLoginWay.text = @"其他登录方式";
        _otherLoginWay.textAlignment = NSTextAlignmentCenter;
    }
    return _otherLoginWay;
}

- (UIButton *)wxBtn {
    if (!_wxBtn) {
        _wxBtn = [self loginWayWithImage:@"Login_WX" tag:0];
    }
    return _wxBtn;
}

- (UIButton *)alipayBtn {
    if (!_alipayBtn) {
        _alipayBtn = [self loginWayWithImage:@"Login_Alipay" tag:1];
    }
    return _alipayBtn;
}

- (UIButton *)loginWayWithImage:(NSString *)image tag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor whiteColor]];
    button.layer.cornerRadius = 30;
    button.layer.masksToBounds = YES;
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.viewModel.otherWayLoginSubject sendNext:@(x.tag)];
    }];
    return button;
}

- (UITextField *)creatTextFieldWithPlaceholder:(NSString *)string {
    UITextField *textfield = [[UITextField alloc] init];
    textfield.font = [UIFont systemFontOfSize:14];
    textfield.placeholder = string;
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:RGB(150, 150, 150)];
    [line setFrame:CGRectMake(0, 40, SCREEN_WIDTH-50, 0.5)];
    [textfield addSubview:line];
    return textfield;
}
@end
