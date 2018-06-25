//
//  ModifyPayPwdViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ModifyPayPwdViewController.h"
#import "ModifyPayPwdViewModel.h"
#import "ModifyPayPwdView.h"

@interface ModifyPayPwdViewController ()
@property (strong, nonatomic) ModifyPayPwdViewModel *viewModel;
@property (strong, nonatomic) ModifyPayPwdView *mainView;
@end

@implementation ModifyPayPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"修改支付密码"];
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
- (ModifyPayPwdView *)mainView {
    if (!_mainView) {
        _mainView = [[ModifyPayPwdView alloc] initWithViewModel:self.viewModel];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (ModifyPayPwdViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ModifyPayPwdViewModel alloc] init];
    }
    return _viewModel;
}
@end
