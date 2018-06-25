//
//  SetingViewController.m
//  PrettyNanny
//
//  Created by together on 2018/4/29.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "SetingViewController.h"
#import "SetingLoginPwdViewController.h"
#import "SetingPayPwdViewController.h"
#import "ModifyPayPwdViewController.h"
#import "ModifyLoginPwdViewController.h"
#import "BindPhoneViewController.h"
#import "TabBarBaseController.h"
//#import "ModifyPhoneViewController.h"

@interface SetingViewController ()
@property (strong, nonatomic) UITableView *table;
@end

@implementation SetingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"设置"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.table];
}

- (void)viewDidLayoutSubviews {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetingCell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = [UserInformation getInformation].userModel.password.length>5 ? @"修改登录密码": @"设置登录密码";
    } else if(indexPath.row == 1){
        cell.textLabel.text = [UserInformation getInformation].userModel.payPassword.length>5 ? @"修改支付密码": @"设置支付密码";
    }else if (indexPath.row ==2) {
        cell.textLabel.text = @"更换绑定手机号";
    }else {
        cell.textLabel.text = @"关于";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            if ( [UserInformation getInformation].userModel.password.length>5) {
                ModifyLoginPwdViewController * setPWD = [[ModifyLoginPwdViewController alloc] init];
                [self.navigationController pushViewController:setPWD animated:YES];
            }else {
                SetingLoginPwdViewController * setPWD = [[SetingLoginPwdViewController alloc] init];
                [self.navigationController pushViewController:setPWD animated:YES];
            }
        }
            break;
        
        case 1: {
            if ( [UserInformation getInformation].userModel.payPassword.length>5) {
                ModifyPayPwdViewController * setPWD = [[ModifyPayPwdViewController alloc] init];
                [self.navigationController pushViewController:setPWD animated:YES];
            }else {
                SetingPayPwdViewController *payPWD = [[SetingPayPwdViewController alloc] init];
                [self.navigationController pushViewController:payPWD animated:YES];
            }   
        }
            break;
        case 2: {
//            ModifyPhoneViewController * setPWD = [[ModifyPhoneViewController alloc] init];
//            [self.navigationController pushViewController:setPWD animated:YES];
        }
            
            break;
        case 3: {
                ModifyPayPwdViewController * setPWD = [[ModifyPayPwdViewController alloc] init];
                [self.navigationController pushViewController:setPWD animated:YES];
        }
            
            break;
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _table.estimatedRowHeight = 0;
            _table.estimatedSectionFooterHeight = 0;
            _table.estimatedSectionHeaderHeight = 0;
            _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"退出登录" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundColor:RGB(255, 212, 60)];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [footView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(footView);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
        }];
        @weakify(self)
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [[UserInformation getInformation] cleanUserInfo];
            TabBarBaseController *main = (TabBarBaseController *)self.tabBarController;
            main.outLoginBlock();
        }];
        _table.tableFooterView = footView;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"SetingCell"];
    }
    return _table;
}

@end
