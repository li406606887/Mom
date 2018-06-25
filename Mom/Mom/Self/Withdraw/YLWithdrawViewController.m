    //
//  YLWithdrawViewController.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLWithdrawViewController.h"
#import "YLWithdrawViewModel.h"
#import "YLWithdrawMainView.h"
@interface YLWithdrawViewController ()
@property (nonatomic,strong) YLWithdrawViewModel *viewModel;
@property (nonatomic,strong) YLWithdrawMainView *mainView;
@end

@implementation YLWithdrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提现";
}
-(void)bindViewModel {
    
    [self.viewModel.drawCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        showMassage(@"提交成功");
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
-(void)setUserModel:(UserDataModel *)userModel {
    if (userModel) {
        self.mainView.userModel = userModel;
    }
}
-(void)addChildView {
    [self.view addSubview:self.mainView];
}

-(void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}
-(YLWithdrawViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLWithdrawViewModel alloc] init];
    }
    return _viewModel;
}
-(YLWithdrawMainView *)mainView {
    if (!_mainView) {
        _mainView = [[YLWithdrawMainView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
