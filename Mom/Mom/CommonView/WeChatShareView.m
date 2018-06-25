//
//  WeChatShareView.m
//  Nanny
//
//  Created by together on 2018/6/21.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "WeChatShareView.h"

@implementation WeChatShareView
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.4]];
        [self addSubview:self.backView];
        [self.backView addSubview:self.lineView];
        [self.backView addSubview:self.refresh];
        [self.backView addSubview:self.copyurlBtn];
        [self.backView addSubview:self.group];
        [self.backView addSubview:self.wechat];
        [self.backView addSubview:self.cancel];
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}

- (void)layoutSubviews {
    
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 150));
    }];
    
    CGFloat x =  (SCREEN_WIDTH)*0.33;
    [self.refresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).with.offset(5);
        make.centerX.equalTo(self).with.offset(-x);
        make.size.mas_offset(CGSizeMake(80, 80));
    }];
    
    [self.group mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).with.offset(5);
        make.centerX.equalTo(self).with.offset((SCREEN_WIDTH)*0.22*2 - x);
        make.size.mas_offset(CGSizeMake(80, 80));
    }];
    
    [self.wechat mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).with.offset(5);
        make.centerX.equalTo(self).with.offset((SCREEN_WIDTH)*0.22*3 - x);
        make.size.mas_offset(CGSizeMake(80, 80));
    }];
    
    [self.copyurlBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).with.offset(5);
        make.centerX.equalTo(self).with.offset((SCREEN_WIDTH)*0.22 - x);
        make.size.mas_offset(CGSizeMake(80, 80));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 0.5));
        make.top.equalTo(self.refresh.mas_bottom).with.offset(5);
        make.centerX.equalTo(self);
    }];
    
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.lineView.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 50));
    }];
    [super layoutSubviews];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:[UIColor whiteColor]];
    }
    return _backView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        [_lineView setBackgroundColor:RGB(222, 222, 222)];
    }
    return _lineView;
}

- (UIButton *)cancel {
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        @weakify(self)
        [[_cancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self removeFromSuperview];
        }];
    }
    return _cancel;
}

- (UIButton *)refresh {
    if (!_refresh) {
        _refresh = [self creatButtonWithTitle:@"刷   新" image:@"shared_refresh" tag:0];
    }
    return _refresh;
}

- (UIButton *)copyurlBtn {
    if (!_copyurlBtn) {
        _copyurlBtn = [self creatButtonWithTitle:@"复   制" image:@"shared_copy" tag:1];
    }
    return _copyurlBtn;
}

- (UIButton *)group {
    if (!_group) {
        _group = [self creatButtonWithTitle:@"朋友圈" image:@"shared_group" tag:2];
    }
    return _group;
}

- (UIButton *)wechat {
    if (!_wechat) {
        _wechat = [self creatButtonWithTitle:@"微   信" image:@"shared_wx" tag:3];
    }
    return _wechat;
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(NSString *)image tag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    button.imageEdgeInsets = UIEdgeInsetsMake(-20, 0, 0, -40);
    button.titleEdgeInsets = UIEdgeInsetsMake(55, -40, 0, 0);
//    button.backgroundColor = [UIColor redColor];
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        if (self.clickBlock) {
            self.clickBlock((int)x.tag);
        }
        [self removeFromSuperview];
    }];
    return button;
}
@end
