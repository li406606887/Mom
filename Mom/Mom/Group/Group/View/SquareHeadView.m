//
//  SquareHeadView.m
//  FamilyFarm
//
//  Created by user on 2017/10/24.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "SquareHeadView.h"

@implementation SquareHeadView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (GroupViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews {
    [self addSubview:self.logo];
    [self addSubview:self.title];
    [self addSubview:self.more];

    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, (SCREEN_WIDTH-20)/2.5));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logo.mas_bottom).with.offset(10);
        make.left.equalTo(self);
        make.size.mas_offset(CGSizeMake(100, 30));
    }];
    
    [self.more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.logo.mas_bottom);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
    
    [super updateConstraints];
   
}

- (GroupBannerView *)logo {
    if (!_logo) {
        _logo = [[GroupBannerView alloc] initWithViewModel:self.viewModel];
    }
    return _logo;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:16];
        _title.text = @"  热议话题";
    }
    return _title;
}

- (UIButton *)more {
    if (!_more) {
        _more = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_more setTitle:@"更多  >    " forState:UIControlStateNormal];
        [_more.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_more setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        @weakify(self)
        [[_more rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            
        }];
    }
    return _more;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
