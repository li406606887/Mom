//
//  PlantingSearchView.m
//  FamilyFarm
//
//  Created by user on 2017/11/1.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "PlantingSearchView.h"
#import "PlantingViewModel.h"

@interface PlantingSearchView()
@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UITextField *searchTextField;
@property(nonatomic,strong) UIButton *searchBtn;
@property(nonatomic,strong) PlantingViewModel *viewModel;
@end

@implementation PlantingSearchView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (PlantingViewModel *)viewModel;
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

@end
