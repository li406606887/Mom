//
//  RealNameAuthenticationViewController.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "RealNameAuthenticationViewController.h"

@interface RealNameAuthenticationViewController ()
@property (weak, nonatomic) IBOutlet UITextField *field;

@end

@implementation RealNameAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"实名认证"];
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
- (IBAction)gotoAuthentication:(id)sender {
    loading(@""); dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError * error;
        QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/findMoon" withParam:@{@"":self.field.text} error:&error];
        dispatch_async(dispatch_get_main_queue(), ^{
            hiddenHUD;
            if (!error) {
                showMassage(@"实名完成");
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                showMassage(model.desc);
            }
        });
    });
}

@end
