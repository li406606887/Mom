//
//  ModifyPhoneView.m
//  Mom
//
//  Created by together on 2018/6/8.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ModifyPhoneView.h"

@implementation ModifyPhoneView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (ModifyPhoneViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.phone];
    [self addSubview:self.validationField];
    [self addSubview:self.login];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(30);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 44));
    }];
    
    [self.validationField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.phone.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 44));
    }];
    
    [self.login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.validationField.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 44));
    }];
    [super updateConstraints];
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
        self.validationBtn.text = @"获取验证码";
        _validationBtn.userInteractionEnabled = YES;
    } else {
        self.validationBtn.text = [NSString stringWithFormat:@"%d秒",self.secondsCount];
        _validationBtn.userInteractionEnabled = NO;
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

- (UITextField *)phone {
    if (!_phone) {
        _phone = [self creatTextFieldWithPlaceholder:@"手机号"];
    }
    return _phone;
}

- (UITextField *)validationField {
    if (!_validationField) {
        _validationField = [self creatTextFieldWithPlaceholder:@"验证码"];
        _validationField.rightView = self.validationBtn;
        _validationField.rightViewMode = UITextFieldViewModeAlways;
    }
    return _validationField;
}

- (UILabel *)validationBtn {
    if (!_validationBtn) {
        _validationBtn = [[UILabel alloc] init];
        [_validationBtn setFrame:CGRectMake(0, 0, 70, 30)];
        _validationBtn.font =[UIFont systemFontOfSize:12];
        _validationBtn.text = @"获取验证码";
        _validationBtn.textColor = RGB(51, 51, 51);
        _validationBtn.textAlignment = NSTextAlignmentRight;
        _validationBtn.userInteractionEnabled = YES;
        @weakify(self)
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            @strongify(self)
            if ([self.phone.text isEqualToString:@""]) {
                showMassage(@"请输入手机号")
                return ;
            }
            if ([QHRequest valiMobile:self.phone.text] == NO) {
                showMassage(@"请输入正确的手机号")
                return ;
            }
            [self.viewModel.getCodeCommand execute:@{@"phone":self.phone.text,@"type":@"6"}];
        }];
        [_validationBtn addGestureRecognizer:tap];
    }
    return _validationBtn;
}

- (UIButton *)login {
    if (!_login) {
        _login = [UIButton buttonWithType:UIButtonTypeCustom];
        [_login setTitle:@"确  定" forState:UIControlStateNormal];
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
            if (self.validationField.text.length < 1) {
                showMassage(@"请输入验证码")
                return ;
            }
            NSDictionary *param = @{@"code":self.validationField.text,@"phone":self.phone.text};
            [self.viewModel.rebindingPhoneCommand execute:param];
        }];
    }
    return _login;
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
