//
//  YLCardManageViewController.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLCardManageViewController.h"
#import "YLCardManageMainView.h"
#import "YLCardManageViewModel.h"
#import "YLAddBankCardViewController.h"

@interface YLCardManageViewController ()
@property (nonatomic,strong) YLCardManageMainView *mainView;
@property (nonatomic,strong) YLCardManageViewModel *viewModel;

@end

@implementation YLCardManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"银行卡管理";
}
-(void)addChildView {
    [self.view addSubview:self.mainView];
}
-(void)bindViewModel {
    WS(weakSelf)
    [[self.viewModel.addBtnClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        YLAddBankCardViewController * AVC = [[YLAddBankCardViewController alloc] init];
        [weakSelf.navigationController pushViewController:AVC animated:YES];
    }];
    
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *  _Nullable x) {
        
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"您确定取消绑定吗？"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  //响应事件
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 NSLog(@"action = %@", action);
                                                                 NSMutableDictionary * dic = [NSMutableDictionary dictionary];
                                                                 [dic setObject:x forKey:@"userBankId"];
                                                                 [weakSelf.viewModel.removeCommand execute:dic];
                                                             }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [weakSelf presentViewController:alert animated:YES completion:nil];

    }];
    
     [self.viewModel.removeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
         [weakSelf.viewModel.getDataCommand execute:nil];
     }];
    
}
-(void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}
-(YLCardManageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLCardManageViewModel alloc] init];
    }
    return _viewModel;
}
-(YLCardManageMainView *)mainView {
    if (!_mainView) {
        _mainView = [[YLCardManageMainView alloc] initWithViewModel:self.viewModel];
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
