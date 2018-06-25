//
//  StoreSearchView.m
//  FamilyFarm
//
//  Created by user on 2017/10/24.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "StoreSearchView.h"
#import "StoreViewModel.h"

@interface StoreSearchView ()
@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UITextField *searchTextField;
@property(nonatomic,strong) UIButton *searchBtn;
@property(nonatomic,strong) UIButton *type;//类型
@property(nonatomic,strong) UIButton *releaseTime;//发布时间
@property(nonatomic,strong) UIButton *hotDegrees;//热度
@property(nonatomic,strong) StoreViewModel *viewModel;
@end

@implementation StoreSearchView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (StoreViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews {
    [self addSubview:self.searchView];
    [self.searchView addSubview:self.searchTextField];
    [self.searchView addSubview:self.searchBtn];
    [self addSubview:self.type];
    [self addSubview:self.releaseTime];
    [self addSubview:self.hotDegrees];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 30));
    }];
    
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchView).with.offset(8);
        make.centerY.equalTo(self.searchView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-86, 30));
    }];
    
    [self.searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.searchView.mas_right);
        make.centerY.equalTo(self.searchView);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
    
    [self.type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(self.searchView.mas_bottom).with.offset(8);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
    
    [self.releaseTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.searchView.mas_bottom).with.offset(8);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
    
    [self.hotDegrees mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.searchView.mas_bottom).with.offset(8);
        make.size.mas_offset(CGSizeMake(60, 30));
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.backgroundColor = [UIColor whiteColor];
    }
    return _searchTextField;
}

-(UIButton *)searchBtn {
    if (!_searchBtn) {
        _searchBtn = [[UIButton alloc] init];
        [_searchBtn setBackgroundColor:[UIColor redColor]];
        [_searchBtn setTitle:@"soso" forState:UIControlStateNormal];
    }
    return _searchBtn;
}

-(UIView *)searchView {
    if (!_searchView) {
        _searchView = [[UIView alloc] init];
        _searchView.layer.masksToBounds = YES;
        _searchView.layer.cornerRadius = 5;
        _searchView.layer.borderWidth = 0.5f;
        _searchView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return _searchView;
}


-(UIButton *)type {
    if (!_type) {
        _type = [UIButton buttonWithType:UIButtonTypeCustom];
        [_type setTitle:@"类型" forState:UIControlStateNormal];
        [_type setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [_type.titleLabel setFont: [UIFont systemFontOfSize:14]];
    }
    return _type;
}

-(UIButton *)releaseTime {
    if (!_releaseTime) {
        _releaseTime = [UIButton buttonWithType:UIButtonTypeCustom];
        [_releaseTime setTitle:@"发布时间" forState:UIControlStateNormal];
        [_releaseTime setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [_releaseTime.titleLabel setFont: [UIFont systemFontOfSize:14]];
    }
    return _releaseTime;
}

-(UIButton *)hotDegrees {
    if (!_hotDegrees) {
        _hotDegrees = [UIButton buttonWithType:UIButtonTypeCustom];
        [_hotDegrees setTitle:@"热度" forState:UIControlStateNormal];
        [_hotDegrees setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [_hotDegrees.titleLabel setFont: [UIFont systemFontOfSize:14]];
    }
    return _hotDegrees;
}
@end
