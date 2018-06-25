//
//  SearchNannyFootView.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SearchNannyFootView.h"

@implementation SearchNannyFootView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.title];
    [self addSubview:self.prompt];
    [self addSubview:self.erCode];
}

- (void)layoutSubviews {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(5);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 40));
    }];
    
    [self.erCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.prompt.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(100, 100));
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.text = @"温馨提示";
    }
    return _title;
}

- (UILabel *)prompt {
    if (!_prompt) {
        _prompt = [[UILabel alloc] init];
        _prompt.font = [UIFont systemFontOfSize:14];
        _prompt.textColor = [UIColor darkGrayColor];
        _prompt.text = @"如果您的护理师或月嫂还没有加入[月靓嫂嫂],请她先扫描二维码加入到[月靓嫂嫂]平台";
        _prompt.numberOfLines = 2;
    }
    return _prompt;
}

- (UIImageView *)erCode {
    if (!_erCode) {
        _erCode = [[UIImageView alloc] init];
        _erCode.backgroundColor = [UIColor blackColor];
    }
    return _erCode;
}
@end
