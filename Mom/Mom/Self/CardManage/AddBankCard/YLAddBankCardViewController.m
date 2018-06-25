//
//  YLAddBankCardViewController.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLAddBankCardViewController.h"
#import "YLAddBankMainView.h"
#import "YLAddBankViewModel.h"

@interface YLAddBankCardViewController ()
@property (nonatomic,strong) YLAddBankMainView *mainView;
@property (nonatomic,strong) YLAddBankViewModel *viewModel;

@end

@implementation YLAddBankCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title =@"添加银行卡";
    
    //GET /api/sys/getBankCardBin
}

-(void)bindViewModel {
    WS(weakSelf)
    [self.viewModel.commitCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       
        showMassage(@"添加成功")
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.viewModel.bankCardBinCommand execute:nil];
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
-(YLAddBankViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLAddBankViewModel alloc] init];
    }
    return _viewModel;
}
-(YLAddBankMainView *)mainView {
    if (!_mainView) {
        _mainView = [[YLAddBankMainView alloc] initWithViewModel:self.viewModel];
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
