//
//  MyRewardHeadView.m
//  Mom
//
//  Created by together on 2018/5/28.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyRewardHeadView.h"

@implementation MyRewardHeadView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.prompt];
        [self addSubview:self.money];
        [self setBackgroundColor:RGB(255, 212, 60)];
    }
    return self;
}

- (void)layoutSubviews {
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(20);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    
    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.prompt.mas_bottom).with.offset(30);
        make.size.mas_offset(CGSizeMake(200, 50));
    }];
    [super layoutSubviews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UILabel *)prompt {
    if (!_prompt) {
        _prompt = [[UILabel alloc] init];
        _prompt.font = [UIFont systemFontOfSize:15];
        _prompt.text = @"已获得奖励(元)";
        _prompt.textAlignment = NSTextAlignmentCenter;
    }
    return _prompt;
}

- (UILabel *)money {
    if (!_money) {
        _money = [[UILabel alloc] init];
        _money.font = [UIFont fontWithName:@"Arial-BoldMT" size:45];
        _money.text = [NSString stringWithFormat:@"%d",[[UserInformation getInformation].userModel.rewardMoney intValue]];
        _money.textAlignment = NSTextAlignmentCenter;
    }
    return _money;
}

@end
