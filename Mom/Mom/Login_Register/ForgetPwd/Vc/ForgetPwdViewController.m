//
//  ForgetPwdViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ForgetPwdView.h"
#import "ForgetPwdViewModel.h"
#import "AgreementViewController.h"

@interface ForgetPwdViewController ()
@property (strong, nonatomic) ForgetPwdView *mainView;
@property (strong, nonatomic) ForgetPwdViewModel *viewModel;
@end

@implementation ForgetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"重置密码"];
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
    [[self.viewModel.resetPwdSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [[self.viewModel.agreementSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        AgreementViewController *agree = [[AgreementViewController alloc] init];
        [self.navigationController pushViewController:agree animated:YES];
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
- (ForgetPwdView *)mainView {
    if (!_mainView) {
        _mainView = [[ForgetPwdView alloc] initWithViewModel:self.viewModel];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (ForgetPwdViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ForgetPwdViewModel alloc] init];
    }
    return _viewModel;
}

@end
