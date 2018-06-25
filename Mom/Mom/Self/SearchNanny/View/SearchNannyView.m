//
//  SearchNannyView.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SearchNannyView.h"

@implementation SearchNannyView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (SearchNannyViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.textField];
    [self addSubview:self.searchBtn];
}

- (void)layoutSubviews {
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.right.equalTo(self.searchBtn.mas_left).with.offset(8);
        make.height.offset(40);
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.size.mas_offset(CGSizeMake(70, 40));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchBtn setTitle:@"搜 索" forState:UIControlStateNormal];
        [_searchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_searchBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        @weakify(self)
        [[_searchBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            [self.viewModel.searchCommand execute:@{@"phone":self.textField.text}];
        }];
    }
    return _searchBtn;
}

-(UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.placeholder = @"请输入护理师的手机号查找";
        _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 30)];
        _textField.leftViewMode = UITextFieldViewModeAlways;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.layer.masksToBounds = YES;
        _textField.layer.cornerRadius = 5;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _textField;
}
@end
