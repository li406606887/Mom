//
//  StoreViewController.m
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "StoreViewController.h"
#import "StoreView.h"
#import "StoreViewModel.h"
#import "ShoppingCartViewController.h"


@interface StoreViewController ()
@property(nonatomic,strong) StoreView * mainView;
@property(nonatomic,strong) StoreViewModel *viewModel;
@end

@implementation StoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
    [self.view addSubview:self.mainView];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(UIBarButtonItem *)rightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundColor:[UIColor redColor]];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        ShoppingCartViewController *shopingCart = [[ShoppingCartViewController alloc] init];
        [self.navigationController pushViewController:shopingCart animated:YES];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(StoreView *)mainView {
    if (!_mainView) {
        _mainView = [[StoreView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

-(StoreViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[StoreViewModel alloc] init];
    }
    return _viewModel;
}
@end
