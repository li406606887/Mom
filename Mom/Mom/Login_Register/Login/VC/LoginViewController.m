//
//  LoginViewController.m
//  FamilyFarm
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "LoginView.h"
#import "PwdLoginViewController.h"
#import "WXApi.h"
#import "BindPhoneViewController.h"
#import "RecommendedViewController.h"
#import "InformationViewController.h"
#import "AgreementViewController.h"
#import "GuidViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) LoginView *mainView;
@property (strong, nonatomic) LoginViewModel *viewModel;
@property (strong, nonatomic) NSString *code;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"注册登录"];
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"WeChatLogin" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self)
//        wxcode
        NSDictionary *data = x.object;
        self.code = [data objectForKey:@"wxcode"];
        [self.viewModel.getWXIDCommand execute:data];
    }];
    
    if (![[[NSUserDefaults standardUserDefaults] objectForKey:@"firstLoading"] isEqualToString:@"isok"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@"isok" forKey:@"firstLoading"];
        [GuidViewController show];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    if ([UserInformation getInformation].loginModel.token.length>5) {
        if (self.releaseBlock) {
            self.releaseBlock();
        }
    }
    [super viewWillAppear:animated];
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
    [[self.viewModel.pwdLoginSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        PwdLoginViewController *pwdLogin = [[PwdLoginViewController alloc] init];
        [self.navigationController pushViewController:pwdLogin animated:YES];
    }];
    
    [self.viewModel.loginSubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        int identity = [[UserInformation getInformation].userModel.identity intValue];
        if ( identity != 2 && identity != 1 &&identity !=3) {
            InformationViewController *information = [[InformationViewController alloc] init];
            [self.navigationController pushViewController:information animated:YES];
        }else {
            self.releaseBlock();
        }
    }];
    
    [[self.viewModel.agreementSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        AgreementViewController *agreem = [[AgreementViewController alloc] init];
        [self.navigationController pushViewController:agreem animated:YES];
    }];
    
    [[self.viewModel.otherWayLoginSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self gotoLoginWithOtherWay:[x intValue]];
    }];
    
    [[self.viewModel.getWXIDSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if ([UserInformation getInformation].loginModel.phone.length<11) {
            [UserInformation getInformation].loginModel.token = @"";
            BindPhoneViewController *bindPhone = [[BindPhoneViewController alloc] init];
            bindPhone.wxcode = self.code;
            bindPhone.openid = [UserInformation getInformation].loginModel.wxOpenid;
            bindPhone.model = [UserInformation getInformation].loginModel;
            [self.navigationController pushViewController:bindPhone animated:YES];
        } else {
//            if (![QHRequest isValidateString:[UserInformation getInformation].loginModel.referrerId]) {
//                RecommendedViewController *recommend = [[RecommendedViewController alloc] init];
//                recommend.model = [UserInformation getInformation].loginModel;
//                [self.navigationController pushViewController:recommend animated:YES];
//            } else
            if ([[UserInformation getInformation].userModel.identity intValue] == 0) {
                InformationViewController *information = [[InformationViewController alloc] init];
                [self.navigationController pushViewController:information animated:YES];
            } else{
                if (self.releaseBlock) {
                    self.releaseBlock();
                }
            }
        }
        
    }];
}

- (UIBarButtonItem *)mainLeftButton {
    return nil;
}

- (void)gotoLoginWithOtherWay:(int)index {
    if (index == 0) {
        if ([WXApi isWXAppInstalled]) {
            SendAuthReq *req = [[SendAuthReq alloc] init];
            req.scope = @"snsapi_userinfo";
            req.state = @"App";
            [WXApi sendReq:req];
        } else {
            [self setupAlertController];
        }
    }else {
        
    }
    
}

#pragma mark - 设置弹出提示语
- (void)setupAlertController {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请先安装微信客户端" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm];
    [self presentViewController:alert animated:YES completion:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (LoginView *)mainView {
    if (!_mainView) {
        _mainView = [[LoginView alloc] initWithViewModel:self.viewModel];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (LoginViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[LoginViewModel alloc] init];
    }
    return _viewModel;
}

@end
