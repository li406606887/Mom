//
//  ModifyLoginPwdViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ModifyLoginPwdViewController.h"
#import "ModifyLoginPwdView.h"
#import "ModifyLoginPwdViewModel.h"

@interface ModifyLoginPwdViewController ()
@property (strong, nonatomic) ModifyLoginPwdViewModel *viewModel;
@property (strong, nonatomic) ModifyLoginPwdView *mainView;
@end

@implementation ModifyLoginPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"登录密码修改"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.modifyPasswordPwdSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController popToRootViewControllerAnimated:YES];
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
- (ModifyLoginPwdView *)mainView {
    if (!_mainView) {
        _mainView = [[ModifyLoginPwdView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (ModifyLoginPwdViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ModifyLoginPwdViewModel alloc] init];
    }
    return _viewModel;
}
@end
