//
//  PassWordLoginView.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "PassWordLoginView.h"

@implementation PassWordLoginView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (PWDLoginViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
- (void)setupViews {
    [self addSubview:self.logo];
    [self addSubview:self.phone];
    [self addSubview:self.pwd];
    [self addSubview:self.isYincang];
    [self addSubview:self.login];
    [self addSubview:self.agreement];
    [self addSubview:self.forgetPwd];
    [self addSubview:self.question];
}

- (void)layoutSubviews {
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(20);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(111, 32));
    }];

    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.logo.mas_bottom).with.offset(30);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 40));
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

    [self.forgetPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.login.mas_right);
        make.top.equalTo(self.login.mas_bottom).with.offset(5);
        make.size.mas_offset(CGSizeMake(70, 38));
    }];

    [self.agreement mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.login.mas_left);
        make.top.equalTo(self.forgetPwd.mas_bottom).with.offset(15);
        make.size.mas_offset(CGSizeMake(140, 44));
    }];

    [self.question mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.login.mas_right);
        make.centerY.equalTo(self.agreement);
        make.size.mas_offset(CGSizeMake(90, 38));
    }];
    
    [super layoutSubviews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"开始点击");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"点击结束");
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
        _logo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Login_Logo"]];
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
        _pwd = [self creatTextFieldWithPlaceholder:@"密码"];
        _pwd.rightView = self.isYincang;
        _pwd.secureTextEntry = YES;
        _pwd.rightViewMode = UITextFieldViewModeAlways;
    }
    return _pwd;
}

- (UIButton *)isYincang {
    if (!_isYincang) {
        _isYincang = [UIButton buttonWithType:UIButtonTypeCustom];
        [_isYincang setFrame:CGRectMake(0, 0, 50, 30)];
        [_isYincang setImage:Image(@"Login_Eye_Hidden") forState:UIControlStateNormal];
        [_isYincang setImage:Image(@"Login_Eye_Hidden_Selected") forState:UIControlStateSelected];
        @weakify(self)
        [[_isYincang rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
           
            self.pwd.secureTextEntry = x.selected;
            x.selected = !x.selected;
        }];
    }
    return _isYincang;
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
                showMassage(@"请输入密码")
                return ;
            }
            NSDictionary *param = @{@"phone":self.phone.text,@"password":self.pwd.text};
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
        [[_agreement rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            NSLog(@"用户协议");
            [self.viewModel.agreementSubject sendNext:nil];
        }];
    }
    return _agreement;
}

- (UIButton *)forgetPwd {
    if (!_forgetPwd) {
        _forgetPwd = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPwd setTitle:@"忘记密码!" forState:UIControlStateNormal];
        [_forgetPwd.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_forgetPwd setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        @weakify(self)
        [[_forgetPwd rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            [self.viewModel.forgetPwdSubject sendNext:nil];
        }];
    }
    return _forgetPwd;
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
