//
//  YLALIBindingViewController.m
//  Mom
//
//  Created by wgz on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLALIBindingViewController.h"

@interface YLALIBindingViewController ()
@property (nonatomic,strong) UIButton *bindingBtn;
@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) UITextField *textField;

@end

@implementation YLALIBindingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"支付宝绑定";
    self.view.backgroundColor = RGB(240, 240, 240);
    
    [self.view addSubview:self.whiteView];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(15);
        make.left.right.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    [self.whiteView addSubview:self.textField];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.whiteView);
        make.left.right.equalTo(self.view).offset(15);
        make.height.mas_offset(45);
    }];
    
    [self.view addSubview:self.bindingBtn];
    [self.bindingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_bottom).offset(19);
        make.left.equalTo(self.view).offset(15);
        make.right.equalTo(self.view).offset(-15);
        make.height.mas_offset(45);
    }];
}
-(void) btnClick {
    
    if (self.textField.text.length < 3) {
        showMassage(@"请输入支付宝账号")
        return;
    }
    WS(weakSelf)
    //    wechatAccount alipayAccount type 类型((1.支付宝账户;2.微信账户;)
    NSMutableDictionary * input = [NSMutableDictionary dictionary];
    [input setObject:@"1" forKey:@"type"];
    [input setObject:self.textField.text forKey:@"alipayAccount"];
    
    loading(@"");
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/setUserThirdPartyAccount" withParam:input error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD
            if (!error) {
                if (self.backBlock) {
                    
                    self.backBlock();
                }
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else {
                showMassage(model.desc);
            }
        });
    });
    
    
}
-(UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.placeholder = @"请输入支付宝账号";
    }
    return _textField;
}
-(UIButton *)bindingBtn {
    if (!_bindingBtn) {
        _bindingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bindingBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_bindingBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _bindingBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [_bindingBtn setBackgroundColor:RGB(255, 218, 68)];
        _bindingBtn.layer.cornerRadius = 5.0f;
        _bindingBtn.layer.masksToBounds = YES;
        [_bindingBtn addTarget:self  action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindingBtn;
}
-(UIView *)whiteView {
    if (!_whiteView) {
        _whiteView = [[UIView alloc] init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
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
