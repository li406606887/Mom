//
//  ModifyPhoneViewController.m
//  Mom
//
//  Created by together on 2018/6/8.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ModifyPhoneViewController.h"
#import "ModifyPhoneViewModel.h"
#import "ModifyPhoneView.h"

@interface ModifyPhoneViewController ()
@property (strong, nonatomic) ModifyPhoneViewModel *viewModel;
@property (strong, nonatomic) ModifyPhoneView *mainView;
@end

@implementation ModifyPhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"绑定手机号"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.rebindingPhoneSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        showMassage(@"绑定成功")
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
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
- (ModifyPhoneView *)mainView {
    if (!_mainView) {
        _mainView = [[ModifyPhoneView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (ModifyPhoneViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[ModifyPhoneViewModel alloc] init];
    }
    return _viewModel;
}
@end
