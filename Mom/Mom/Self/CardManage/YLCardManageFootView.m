//
//  YLCardManageFootView.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLCardManageFootView.h"
#import "YLCardManageViewModel.h"

@interface YLCardManageFootView ()
@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) YLCardManageViewModel *viewModel;

@end

@implementation YLCardManageFootView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLCardManageViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {
    
}

-(void)btnClick {
    
    [self.viewModel.addBtnClickSubject sendNext:nil];
}
-(void)setupViews {
    self.backgroundColor = RGB(240, 240, 240);
    
    [self addSubview:self.addBtn];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {

    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(19);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
        make.height.mas_offset(45);
    }];

    [super updateConstraints];
}

-(UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [_addBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        //        [_rechargeBtn setBackgroundColor:RGB(255, 218, 68) forState:UIControlStateNormal];
        [_addBtn setBackgroundColor:RGB(255, 218, 68)];
        _addBtn.layer.cornerRadius = 5.0f;
        _addBtn.layer.masksToBounds = YES;
        [_addBtn addTarget:self  action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}
-(YLCardManageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLCardManageViewModel alloc] init];
    }
    return _viewModel;
}
@end
