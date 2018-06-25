//
//  PwdLoginViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "PwdLoginViewController.h"
#import "PWDLoginViewModel.h"
#import "PassWordLoginView.h"
#import "ForgetPwdViewController.h"
#import "AgreementViewController.h"

@interface PwdLoginViewController ()
//@property (strong, nonatomic) PWDLoginView *mainView;
@property (strong, nonatomic) PassWordLoginView *mainView;
@property (strong, nonatomic) PWDLoginViewModel *viewModel;
@end

@implementation PwdLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"密码登录"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)viewDidLayoutSubviews {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.forgetPwdSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        ForgetPwdViewController *forget = [[ForgetPwdViewController alloc] init];
        [self.navigationController pushViewController:forget animated:YES];
    }];
    
    [[self.viewModel.agreementSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        AgreementViewController *agree = [[AgreementViewController alloc] init];
        [self.navigationController pushViewController:agree animated:YES];
    }];
    
    [self.viewModel.loginSubject subscribeNext:^(id  _Nullable x) {
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

- (PassWordLoginView *)mainView {
    if (!_mainView) {
        _mainView = [[PassWordLoginView alloc] initWithViewModel:self.viewModel];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (PWDLoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PWDLoginViewModel alloc] init];
    }
    return _viewModel;
}

@end
