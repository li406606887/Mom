//
//  PayMoneyViewController.m
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "PayMoneyViewController.h"
#import "PaySuccessViewController.h"
#import "WXApi.h"
#import "WXPayModel.h"
#import "PaySuccessViewController.h"

@interface PayMoneyViewController ()<WXApiDelegate>
@property (weak, nonatomic) IBOutlet UILabel *promptTextView;

@end

@implementation PayMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"支付"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.promptTextView.text = @"线上支付您将获得以下奖励\n1.儿童摄影体验.\n2.方特旅游度假区一日游";
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.outLinePaySuccessSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.viewModel.onLinePaySuccessSubject subscribeNext:^(id  _Nullable x) {
        [self weichatPayWithPrama:(WXPayModel *)x];
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"PayResult" object:nil] subscribeNext:^(NSNotification *notification) {
        NSLog(@"%@", notification.name);
        NSLog(@"%@", notification.object);
        PaySuccessViewController *paysuccess = [[PaySuccessViewController alloc] init];
        [self.navigationController pushViewController:paysuccess animated:YES];
    }];
}

- (IBAction)outLinePayMoney:(id)sender {
    if (self.model.totalMoney==nil) {
        return;
    }
    [self.viewModel.outLinePayCommand execute:@{@"moonOrderId":self.model.ID,@"channel":@"OFFLINE",@"money":self.model.totalMoney}];
}
- (IBAction)OnlinePayMoney:(id)sender {
    if (self.model.totalMoney==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入您要支付的金额" preferredStyle:UIAlertControllerStyleAlert];
        //增加取消按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        //增加确定按钮
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            //获取第1个输入框
            UITextField *userNameTextField = alert.textFields.firstObject;
            [self.viewModel.onliePayCommand execute:@{@"moonOrderId":self.model.ID,@"channel":@"WECHAT",@"money":userNameTextField.text,@"appSource":@"mother"}];
        }]];
        //定义第一个输入框；
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = @"请输入支付金额";
            textField.keyboardType = UIKeyboardTypeNumberPad;
        }];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        [self.viewModel.onliePayCommand execute:@{@"moonOrderId":self.model.ID,@"channel":@"WECHAT",@"money":self.model.totalMoney,@"appSource":@"mother"}];
    }
}

- (void)setModel:(NannyModel *)model {
    _model = model;
}

-(void)weichatPayWithPrama:(WXPayModel *)model {
    
    PayReq *request = [[PayReq alloc] init];
    
    request.partnerId = model.partnerid;//商户号 可以写死
    
    request.prepayId= model.prepayid;//预支付交易会话ID
    
    request.package = model.packages;//扩展字段 固定
    
    request.nonceStr= model.noncestr;//[self generateTradeNO];//随机字符串
    
    NSString * time = model.timestamp;
    request.timeStamp = [time intValue];//[self timeStamp]; (UInt32)
    
    request.sign= model.sign;//后台返回的签名
    
    [WXApi sendReq:request];

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (PayMoneyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PayMoneyViewModel alloc] init];
    }
    return _viewModel;
}
@end
