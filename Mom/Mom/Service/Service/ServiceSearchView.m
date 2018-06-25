//
//  ServiceSearchView.m
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "ServiceSearchView.h"



@implementation ServiceSearchView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (ServiceViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.searchView];
    [self.searchView addSubview:self.searchTextField];
    [self.searchView addSubview:self.searchBtn];
    
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
}

-(void)setTitle:(NSString *)title {
    NSArray *titleArray = [NSArray arrayWithObjects:@"全部",@"培训学习",@"兴趣爱好",@"户外活动",@"周边游", nil];
    for (int i = 0; i<5; i++) {
        UIButton *typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [typeBtn setTitle:titleArray[i] forState:UIControlStateNormal];
        [typeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [typeBtn.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [typeBtn.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [self addSubview:typeBtn];
        CGFloat width = i*(SCREEN_WIDTH-20)/5;
        [typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.searchView.mas_bottom);
            make.left.equalTo(self.searchView).with.offset(width+10);
            make.size.mas_offset(CGSizeMake(60, 30));
        }];
    }
}

-(UITextField *)searchTextField {
    if (!_searchTextField) {
        _searchTextField = [[UITextField alloc] init];
        _searchTextField.backgroundColor = [UIColor whiteColor];
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.layer.cornerRadius = 5;
        _searchTextField.placeholder = @"";
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
@end
