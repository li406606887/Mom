
//
//  SetingLoginPwdView.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "SetingLoginPwdView.h"

@implementation SetingLoginPwdView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (SetingLoginPwdViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.pwdField];
    [self addSubview:self.surePwdField];
    [self addSubview:self.login];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(30);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
    
    [self.surePwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.pwdField.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
    
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.surePwdField.mas_bottom).with.offset(30);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 44));
    }];
    [super updateConstraints];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (UITextField *)pwdField {
    if (!_pwdField) {
        _pwdField = [self creatTextFieldWithPlaceholder:@"新密码(6-20位数字与字母组合)"];
    }
    return _pwdField;
}

- (UITextField *)surePwdField {
    if (!_surePwdField) {
        _surePwdField = [self creatTextFieldWithPlaceholder:@"请再次输入新密码"];
    }
    return _surePwdField;
}

- (UIButton *)login {
    if (!_login) {
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        [_login setTitle:@"保存登录密码" forState:UIControlStateNormal];
        [_login setBackgroundColor:RGB(254, 211, 54)];
        [_login setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        @weakify(self)
        [[_login rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (![self.surePwdField.text isEqualToString:self.pwdField.text]) {
                showMassage(@"两次密码不一致");
                return ;
            }
            NSDictionary *param = @{@"password":self.surePwdField.text,@"oldPassword":@""};
            [self.viewModel.setingPwdCommand execute:param];
        }];
    }
    return _login;
}

- (UITextField *)creatTextFieldWithPlaceholder:(NSString *)string {
    UITextField *textfield = [[UITextField alloc] init];
    textfield.font = [UIFont systemFontOfSize:14];
    textfield.placeholder = string;
    textfield.secureTextEntry = YES;
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:RGB(150, 150, 150)];
    [line setFrame:CGRectMake(0, 40, SCREEN_WIDTH-30, 0.5)];
    [textfield addSubview:line];
    UIButton *isVisible = [UIButton buttonWithType:UIButtonTypeCustom];
    [isVisible setImage:[UIImage imageNamed:@"Login_Eye_Hidden"] forState:UIControlStateNormal];
    [isVisible setImage:[UIImage imageNamed:@"Login_Eye_Hidden_Selected"] forState:UIControlStateSelected];
    isVisible.frame = CGRectMake(0, 0, 70, 44);
    @weakify(textfield)
    [[isVisible rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(textfield)
        textfield.secureTextEntry = x.selected;
        x.selected = !x.selected;
    }];
    textfield.rightView = isVisible;
    textfield.rightViewMode = UITextFieldViewModeAlways;
    return textfield;
}
@end
