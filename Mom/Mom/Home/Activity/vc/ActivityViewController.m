//
//  ActivityViewController.m
//  Mom
//
//  Created by together on 2018/5/28.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ActivityViewController.h"

@interface ActivityViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *headicon;
@property (weak, nonatomic) IBOutlet UILabel *contenTitle;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *joinNub;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *joinBtn;
@property (weak, nonatomic) IBOutlet UILabel *status;
@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"活动详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)joinClick:(id)sender {
    if ([self.model.status intValue] == 1) {
        loading(@"");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError * error;
            QHRequestModel *model = [QHRequest postDataWithApi:@"/api/activity/cancelApply" withParam:@{@"activityId":self.model.ID} error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hiddenHUD;
                if (!error) {
                    self.model.status = @"0";
                    NSString *str = [self.model.status intValue] == 1 ? @"取消报名":@"报名";
                    [self.joinBtn setTitle:str forState:UIControlStateNormal];
                    self.status.text = [self.model.status intValue] == 1 ? @"已报名":@"报名";
                }else {
                    showMassage(model.desc);
                }
            });
        });
    }else {
        loading(@"");
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSError * error;
            QHRequestModel *model = [QHRequest postDataWithApi:@"/api/activity/apply" withParam:@{@"activityId":self.model.ID} error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                hiddenHUD;
                if (!error) {
                    self.model.status = @"1";
                    NSString *str = [self.model.status intValue] == 1 ? @"取消报名":@"报名";
                    [self.joinBtn setTitle:str forState:UIControlStateNormal];
                    self.status.text = [self.model.status intValue] == 1 ? @"已报名":@"报名";
                }else {
                    showMassage(model.desc);
                }
            });
        });
    }
}

- (void)setModel:(FarmModel *)model {
    _model = model;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setTitle:model.title];
        [self.headicon sd_setImageWithURL:[NSURL URLWithString:model.url]];
        self.contenTitle.text = model.title;
        self.time.text = model.actTime;
        self.joinNub.text = [NSString stringWithFormat:@"报名人数:%@",model.applyQuantity];
        self.status.text = [model.status intValue] == 1 ? @"已报名":@"报名";
        NSString *str = [model.status intValue] == 1 ? @"取消报名":@"报名";
        [self.joinBtn setTitle:str forState:UIControlStateNormal];
    });
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
