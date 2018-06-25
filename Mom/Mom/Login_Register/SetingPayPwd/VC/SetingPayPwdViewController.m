//
//  SetingPayPwdViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "SetingPayPwdViewController.h"
#import "SetingPayPwdViewModel.h"
#import "SetingPayPwdView.h"

@interface SetingPayPwdViewController ()
@property (strong, nonatomic) SetingPayPwdViewModel *viewModel;
@property (strong, nonatomic) SetingPayPwdView *mainView;
@end

@implementation SetingPayPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置支付密码"];
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
        [[self.viewModel.setingPwdSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
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
- (SetingPayPwdView *)mainView {
    if (!_mainView) {
        _mainView = [[SetingPayPwdView alloc] initWithViewModel:self.viewModel];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (SetingPayPwdViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SetingPayPwdViewModel alloc] init];
    }
    return _viewModel;
}
@end
