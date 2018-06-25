//
//  ShoppingCartHeadView.m
//  FamilyFarm
//
//  Created by user on 2017/10/31.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "ShoppingCartHeadView.h"
#import "ShoppingCartViewModel.h"

@interface ShoppingCartHeadView ()
@property(nonatomic,strong) ShoppingCartViewModel *viewModel;
@property(nonatomic,strong) UIButton *selecedAll;
@property(nonatomic,strong) UILabel *title;
@end

@implementation ShoppingCartHeadView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (ShoppingCartViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.selecedAll];
    [self addSubview:self.title];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.selecedAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selecedAll.mas_right).with.offset(10);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(UIButton *)selecedAll {
    if (!_selecedAll) {
        _selecedAll = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selecedAll setBackgroundColor:[UIColor greenColor]];
        [[_selecedAll rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            x.selected = !x.selected;
            if(x.selected ==YES){
                x.backgroundColor = [UIColor redColor];
            }else {
                x.backgroundColor = [UIColor greenColor];
            }
        }];
    }
    return _selecedAll;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.text = @"满99元包邮";
    }
    return _title;
}
@end
