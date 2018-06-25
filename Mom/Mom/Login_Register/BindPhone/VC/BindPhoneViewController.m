//
//  BindPhoneViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BindPhoneViewController.h"
#import "BindPhoneViewModel.h"
#import "BindPhoneView.h"
#import "InformationViewController.h"

@interface BindPhoneViewController ()
@property (strong, nonatomic) BindPhoneViewModel *viewModel;
@property (strong, nonatomic) BindPhoneView *mainView;
@end

@implementation BindPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTitle:@"绑定手机"];
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

- (void)setWxcode:(NSString *)wxcode {
    self.viewModel.wxcode = wxcode;
}

- (void)setOpenid:(NSString *)openid {
    self.viewModel.openId = openid;
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.rebindingPhoneSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
//        RecommendedViewController *forget = [[RecommendedViewController alloc] init];
//        forget.model = self.model;
//        [self.navigationController pushViewController:forget animated:YES];
        if ([[UserInformation getInformation].userModel.identity intValue] == 0) {
            InformationViewController *forget = [[InformationViewController alloc] init];
            [self.navigationController pushViewController:forget animated:YES];
        }else {
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
}

- (void)setModel:(LoginModel *)model {
    _model = model;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (BindPhoneView *)mainView {
    if (!_mainView) {
        _mainView = [[BindPhoneView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (BindPhoneViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[BindPhoneViewModel alloc] init];
    }
    return _viewModel;
}

@end
