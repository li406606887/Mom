//
//  GroupDetailsToolView.m
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "GroupDetailsToolView.h"

@implementation GroupDetailsToolView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (GroupDetailsViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}

- (void)setupViews {
    [self addSubview:self.headIcon];
    [self addSubview:self.textFile];
    [self addSubview:self.send];
}

- (void)layoutSubviews {
    
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    [self.textFile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.centerY.equalTo(self.headIcon);
        make.right.equalTo(self.send.mas_left).with.offset(-10);
        make.height.equalTo(@(40));
    }];
    
    [self.send mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self.headIcon);
        make.size.mas_offset(CGSizeMake(60, 40));
    }];
    [super layoutSubviews];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    if (self.textFile.text.length<1) {
        showMassage(@"请输入评论内容");
        return YES;
    }
    [self.viewModel.sendTextCommand execute:@{@"circleId":self.viewModel.model.ID,@"content":textField.text}];
    self.textFile.text = @"";
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        _headIcon.layer.masksToBounds = YES;
        _headIcon.layer.cornerRadius = 20;
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:[UserInformation getInformation].userModel.headUrl] placeholderImage:[UIImage imageNamed:@"monther_default_icon"]];
    }
    return _headIcon;
}

- (UITextField *)textFile {
    if (!_textFile) {
        _textFile = [[UITextField alloc] init];
        _textFile.delegate = self;
        _textFile.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 40)];
        _textFile.leftViewMode = UITextFieldViewModeAlways;
        _textFile.layer.borderWidth = 0.5;
        _textFile.layer.borderColor = RGB(200, 200, 200).CGColor;
        _textFile.layer.masksToBounds = YES;
        _textFile.layer.cornerRadius = 4;
        _textFile.placeholder = @"请输入要回复的内容";
        _textFile.font = [UIFont systemFontOfSize:14];
        _textFile.returnKeyType = UIReturnKeySend;
    }
    return _textFile;
}

- (UIButton *)send {
    if (!_send) {
        _send = [UIButton buttonWithType:UIButtonTypeCustom];
        [_send.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_send setTitle:@"提交" forState:UIControlStateNormal];
        [_send setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_send setBackgroundColor:RGB(255, 212, 60)];
        _send.layer.masksToBounds = YES;
        _send.layer.cornerRadius = 3;
        @weakify(self)
        [[_send rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.textFile resignFirstResponder];
            if (self.textFile.text.length<1) {
                showMassage(@"请输入评论内容")
            }else{
                [self.viewModel.sendTextCommand execute:@{@"circleId":self.viewModel.model.ID,@"content":self.textFile.text}];
                self.textFile.text = @"";
            }
        }];
    }
    return _send;
}
@end
