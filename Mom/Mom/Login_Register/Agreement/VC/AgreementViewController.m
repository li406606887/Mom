//
//  AgreementViewController.m
//  Mom
//
//  Created by together on 2018/6/4.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "AgreementViewController.h"

@interface AgreementViewController ()
@property (strong, nonatomic) UIWebView *webView;
@end

@implementation AgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"用户协议"];
    [self getAgreement];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getAgreement {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/agreement" withParam:nil error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!error) {
                [self.webView loadHTMLString:[model.content objectForKey:@"content"] baseURL:nil];
            }else {
                showMassage(model.desc);
            }
        });
    });
}
- (void)viewDidLayoutSubviews {
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super viewDidLayoutSubviews];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.delegate = self;
        _webView.dataDetectorTypes = UIDataDetectorTypeAll;
        _webView.backgroundColor = RGB(242, 242, 242);
    }
    return _webView;
}
@end
