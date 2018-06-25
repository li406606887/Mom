//
//  CouponsDetailsViewController.m
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "CouponsDetailsViewController.h"

@interface CouponsDetailsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *couponsTitle;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *useDate;
@property (weak, nonatomic) IBOutlet UILabel *state;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UILabel *useTime;
@property (weak, nonatomic) IBOutlet UILabel *instructions;
@end

@implementation CouponsDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setModel:(CouponsModel *)model {
    _model = model;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.couponsTitle.text = model.title;
        self.content.text = model.content;
        self.useDate.text = [@"有效期:" stringByAppendingString:model.validity];
        self.state.text = [model.isUse intValue] == 1 ? @"未使用":@"已使用";
        self.useTime.text = model.introduce;
        self.code.text = model.couponCode;
        self.instructions.text = model.explanation;
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
