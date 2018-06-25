//
//  ServiceViewController.m
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "ServiceViewController.h"
#import "ServiceViewModel.h"
#import "ServiceView.h"

@interface ServiceViewController ()
@property(nonatomic,strong) ServiceView * mainView;
@property(nonatomic,strong) ServiceViewModel *viewModel;
@end

@implementation ServiceViewController

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
-(ServiceView *)mainView {
    if (!_mainView) {
        _mainView = [[ServiceView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

-(ServiceViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ServiceViewModel alloc] init];
    }
    return _viewModel;
}
@end
