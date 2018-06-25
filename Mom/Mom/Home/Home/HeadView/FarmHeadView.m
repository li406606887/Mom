//
//  FarmHeadView.m
//  FamilyFarm
//
//  Created by user on 2017/10/19.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "FarmHeadView.h"
#import "HomeScrollView.h"
#import "FarmViewModel.h"
#import "FarmHeadItemView.h"

@interface FarmHeadView()
@property(nonatomic,strong) HomeScrollView *bannerView;
@property(nonatomic,strong) FarmViewModel *viewModel;
@property(nonatomic,strong) FarmHeadItemView *itemView;
@end

@implementation FarmHeadView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (FarmViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews {
    [self addSubview:self.bannerView];
    [self addSubview:self.itemView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 150));
    }];
    
    [self.itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.bannerView.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 110));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(HomeScrollView *)bannerView {
    if (!_bannerView) {
        _bannerView = [[HomeScrollView alloc] initWithViewModel:self.viewModel];
        _bannerView.backgroundColor = [UIColor greenColor];
    }
    return _bannerView;
}
-(FarmHeadItemView *)itemView {
    if (!_itemView) {
        _itemView = [[FarmHeadItemView alloc] initWithViewModel:self.viewModel];
    }
    return _itemView;
}
@end
