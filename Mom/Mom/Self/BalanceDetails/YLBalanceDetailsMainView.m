//
//  YLBalanceDetailsMainView.m
//  DXYiGe
//
//  Created by JHT on 2018/5/23.
//  Copyright © 2018年 QC. All rights reserved.
//

#import "YLBalanceDetailsMainView.h"
#import "YLBalanceDetailsViewModel.h"
#import "YLBalanceDetailsAllView.h"
#import "YLBalanceIncomeView.h"
#import "YLBalancePayoutView.h"
#import "YLSegmentedScrollView.h"

@interface YLBalanceDetailsMainView ()<UIScrollViewDelegate>
@property (nonatomic,strong) YLBalanceDetailsViewModel *viewModel;
@property (nonatomic,strong) YLBalanceDetailsAllView *allView;
@property (nonatomic,strong) YLBalanceIncomeView *incomeView;
@property (nonatomic,strong) YLBalancePayoutView *payoutView;

@property (nonatomic,strong) YLSegmentedScrollView *segmentScrollView;
@property (nonatomic,strong) UIScrollView *bottomScrollView;

@end

@implementation YLBalanceDetailsMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLBalanceDetailsViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}

-(void)bindViewModel {
    
}
//scroller代理
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {
    if (scrollView == self.bottomScrollView) {
        int resut =  (int) scrollView.contentOffset.x/SCREEN_WIDTH;
        self.segmentScrollView.selectedIndex = resut;
        [self updateCellContentSizeWithIndex:resut];
    }
}
-(void)updateCellContentSizeWithIndex:(int)index {
    
}
-(YLBalanceDetailsAllView *)allView {
    if (!_allView) {
        _allView = [[YLBalanceDetailsAllView alloc] initWithViewModel:self.viewModel];
        //        _allView.backgroundColor = RGB(100, 0, 0);
    }
    return _allView;
}
-(YLBalanceIncomeView *)incomeView {
    if (!_incomeView) {
        _incomeView = [[YLBalanceIncomeView alloc] initWithViewModel:self.viewModel];
        //        _incomeView.backgroundColor = [UIColor whiteColor];
    }
    return _incomeView;
}
-(YLBalancePayoutView *)payoutView {
    if (!_payoutView) {
        _payoutView = [[YLBalancePayoutView alloc] initWithViewModel:self.viewModel];
        //        _payoutView.backgroundColor = RGB(240, 240, 240);
    }
    return _payoutView;
}
-(UIScrollView *)bottomScrollView {
    if (!_bottomScrollView) {
        _bottomScrollView = [[UIScrollView alloc] init];
        _bottomScrollView.backgroundColor = [UIColor whiteColor];
        _bottomScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*3, 100);
        _bottomScrollView.pagingEnabled = YES;
        _bottomScrollView.delegate = self;
        _bottomScrollView.showsHorizontalScrollIndicator = NO;
        
        [_bottomScrollView addSubview:self.allView];
        [_bottomScrollView addSubview:self.incomeView];
        [_bottomScrollView addSubview:self.payoutView];
        [self.allView setFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-32)];
        [self.incomeView setFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT-32)];
        [self.payoutView setFrame:CGRectMake(SCREEN_WIDTH*2, 0, SCREEN_WIDTH, SCREEN_HEIGHT-32)];
    }
    return _bottomScrollView;
}

-(YLSegmentedScrollView *)segmentScrollView {
    if (!_segmentScrollView) {
        NSArray * temp = [NSArray arrayWithObjects:@"全部",@"收入",@"支出", nil];
        _segmentScrollView = [[YLSegmentedScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) item:temp];
        _segmentScrollView.lineColor = RGB(255, 218, 68);
        _segmentScrollView.selectedTitleColor = RGB(31, 31, 31);
        _segmentScrollView.defultTitleColor = RGB(31, 31, 31);
        _segmentScrollView.backgroundColor = [UIColor whiteColor];
        WS(weakSelf)
        _segmentScrollView.itemClick = ^(int index) {
            [weakSelf.bottomScrollView setContentOffset:CGPointMake(SCREEN_WIDTH*index, 0) animated:YES];
            [weakSelf updateCellContentSizeWithIndex:index];
        };
        
        [_segmentScrollView show];
    }
    return _segmentScrollView;
}

-(void)setupViews {
    [self addSubview:self.segmentScrollView];
    [self addSubview:self.bottomScrollView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [self.segmentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_offset(32);
    }];
    [self.bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.top.equalTo(self.segmentScrollView.mas_bottom);
    }];
    [super updateConstraints];
}
- (YLBalanceDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLBalanceDetailsViewModel alloc] init];
    }
    return _viewModel;
}

/*
 all in Income out pay out
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
