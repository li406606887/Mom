//
//  YLAccountBindingViewController.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLAccountBindingViewController.h"
#import "YLAccountBindingMainView.h"
#import "YLAccountBindingViewModel.h"
#import "YLWeixinBindingViewController.h"
#import "YLALIBindingViewController.h"

@interface YLAccountBindingViewController ()
@property (nonatomic,strong) YLAccountBindingMainView *mainView;
@property (nonatomic,strong) YLAccountBindingViewModel *viewModel;


@end

@implementation YLAccountBindingViewController
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
     [self.viewModel.getUserDateCommand execute:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title =@"账号绑定";
}
-(void)setUserModel:(UserDataModel *)userModel {
    if (userModel) {
        self.mainView.userModel = userModel;
    }
}
-(void) cancelBinding:(NSString*)x {
    //    wechatAccount alipayAccount type 类型((1.支付宝账户;2.微信账户;)
    NSMutableDictionary * input = [NSMutableDictionary dictionary];
    
    if ([x isEqualToString:@"0"]) {
        //微信解除
        NSLog(@"微信解除");
        [input setObject:@"2" forKey:@"type"];
        [input setObject:@"" forKey:@"wechatAccount"];
    }else if([x isEqualToString:@"1"]) {
        NSLog(@"支付宝解除");
        [input setObject:@"1" forKey:@"type"];
        [input setObject:@"" forKey:@"alipayAccount"];
    }
    
    [self.viewModel.cancelBindCommand execute:input];
}
-(void)bindViewModel {
    
    WS(weakSelf)
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
//        YLWeixinBindingViewController *WVC = [[YLWeixinBindingViewController alloc] init];
//        [weakSelf.navigationController pushViewController:WVC animated:YES];
    }];
    
    [[self.viewModel.bindSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *  _Nullable x) {
        if ([x isEqualToString:@"0"]) {
            YLWeixinBindingViewController *WVC = [[YLWeixinBindingViewController alloc] init];
            WVC.backBlock = ^{
                [weakSelf.viewModel.getUserDateCommand execute:nil];
            };
            [weakSelf.navigationController pushViewController:WVC animated:YES];
        }else if([x isEqualToString:@"1"]) {
            YLALIBindingViewController *WVC = [[YLALIBindingViewController alloc] init];
            WVC.backBlock = ^{
                [weakSelf.viewModel.getUserDateCommand execute:nil];
            };
            [weakSelf.navigationController pushViewController:WVC animated:YES];
        }
    }];
    
    [[self.viewModel.noBindSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *  _Nullable x) {
        
        
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
                                                                 [weakSelf cancelBinding:x];
                                                             }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
        
      
    }];
    
    [self.viewModel.cancelBindCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        showMassage(@"解除绑定成功")
        [self.viewModel.getUserDateCommand execute:nil];
    }];
    
    [self.viewModel.getUserDateCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        UserDataModel * model = [UserDataModel mj_objectWithKeyValues:x];
        
        self.mainView.userModel = model;
    }];
    
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
-(YLAccountBindingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLAccountBindingViewModel alloc] init];
    }
    return _viewModel;
}
-(YLAccountBindingMainView *)mainView {
    if (!_mainView) {
        _mainView = [[YLAccountBindingMainView alloc] initWithViewModel:self.viewModel];
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
