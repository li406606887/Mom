//
//  YLBalanceDetailsViewController.m
//  DXYiGe
//
//  Created by JHT on 2018/5/23.
//  Copyright © 2018年 QC. All rights reserved.
//

#import "YLBalanceDetailsViewController.h"
#import "YLBalanceDetailsMainView.h"
#import "YLBalanceDetailsViewModel.h"

@interface YLBalanceDetailsViewController ()
@property (nonatomic,strong) YLBalanceDetailsMainView *mainView;
@property (nonatomic,strong) YLBalanceDetailsViewModel *viewModel;
@end

@implementation YLBalanceDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"余额明细";
}

-(void)addChildView {
    [self.view addSubview:self.mainView];
}
-(void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}
-(YLBalanceDetailsMainView *)mainView {
    if (!_mainView) {
        _mainView = [[YLBalanceDetailsMainView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
-(YLBalanceDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLBalanceDetailsViewModel alloc] init];
    }
    return _viewModel;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
