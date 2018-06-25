//
//  PlantingViewController.m
//  FamilyFarm
//
//  Created by user on 2017/11/1.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "PlantingViewController.h"
#import "PlantingViewModel.h"
#import "PlantingView.h"

@interface PlantingViewController ()
@property(nonatomic,strong) PlantingViewModel *viewModel;
@property(nonatomic,strong) PlantingView * mainView;
@end

@implementation PlantingViewController

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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(PlantingView *)mainView {
    if (!_mainView) {
        _mainView = [[PlantingView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

-(PlantingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PlantingViewModel alloc] init];
    }
    return _viewModel;
}
@end
