//
//  YLRechargeViewController.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//


#import "YLRechargeViewController.h"
#import "YLRechargeMainView.h"
#import "YLRechargeViewModel.h"
#import "WXApi.h"

@interface YLRechargeViewController ()
@property (nonatomic,strong) YLRechargeMainView *mainView;
@property (nonatomic,strong) YLRechargeViewModel *viewModel;
@end

@implementation YLRechargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"充值";
    
}
-(void)bindViewModel {
    WS(weakSelf)
    [[self.viewModel.rechargeSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *  _Nullable money) {
        
        NSLog(@"money->%@",money);
        //向后台请求支付参数
        
        //调起支付
        
#warning 请求参数
        [weakSelf weichatPayWithPrama:nil];
    }];
}

-(void)weichatPayWithPrama:(NSDictionary *)prama {
    
    PayReq *request = [[PayReq alloc] init];
    
    request.partnerId = [prama objectForKey:@"mch_id"];//商户号 可以写死
    
    request.prepayId= [prama objectForKey:@"prepay_id"];//预支付交易会话ID
    
    request.package = @"Sign=WXPay";//扩展字段 固定
    request.nonceStr= [prama objectForKey:@"noncestr"];//[self generateTradeNO];//随机字符串
    
    NSString * time = [NSString stringWithFormat:@"%@", [prama objectForKey:@"timestamp"]];
    request.timeStamp = [time intValue];//[self timeStamp]; (UInt32)
    
    request.sign= [prama objectForKey:@"paySign"];//后台返回的签名
    
    [WXApi sendReq:request];
    
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
-(YLRechargeMainView *)mainView {
    if (!_mainView) {
        _mainView = [[YLRechargeMainView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
-(YLRechargeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLRechargeViewModel alloc] init];
    }
    return _viewModel;
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
