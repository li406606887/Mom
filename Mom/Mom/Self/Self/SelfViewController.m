//
//  SelfViewController.m
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "SelfViewController.h"
#import "SelfView.h"
#import "SelfViewModel.h"
#import "InformationViewController.h"
#import "MyInformationViewController.h"
#import "CouponsViewController.h"
#import "MyNannyViewController.h"
#import "MyBabyViewController.h"
#import "DemandViewController.h"
#import "SetingViewController.h"
#import "YLWalletViewController.h"
#import "MyRewardViewController.h"
#import "GetCouponViewController.h"

@interface SelfViewController ()
@property(nonatomic,strong) SelfView *mainView;
@property(nonatomic,strong) SelfViewModel *viewModel;
@end

@implementation SelfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel.refreshHeadInfoSubject sendNext:nil];
}

-(void)addChildView {
    [self.view addSubview:self.mainView];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [[self.viewModel.modifyInfoClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        MyInformationViewController *information = [[MyInformationViewController alloc] init];
        [self.navigationController pushViewController:information animated:YES];
    }];
    
    [[self.viewModel.headIconClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        InformationViewController *information = [[InformationViewController alloc] init];
        [self.navigationController pushViewController:information animated:YES];
    }];
    
    [[self.viewModel.selfItemClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        switch ([x intValue]) {
            case 0:{
                YLWalletViewController *wallet = [[YLWalletViewController alloc] init];
                [self.navigationController pushViewController:wallet animated:YES];
            }
                break;
            case 1:{
                MyBabyViewController *myBaby = [[MyBabyViewController alloc] init];
                [self.navigationController pushViewController:myBaby animated:YES];
            }
                break;
            case 2:{
                MyNannyViewController *myNanny = [[MyNannyViewController alloc] init];
                [self.navigationController pushViewController:myNanny animated:YES];
            }
                break;
            case 3:{
                DemandViewController *demand = [[DemandViewController alloc] init];
                [self.navigationController pushViewController:demand animated:YES];
            }
                break;
//            case 4:{
//                MyRewardViewController *coupons = [[MyRewardViewController alloc] init];
//                [self.navigationController pushViewController:coupons animated:YES];
//            }
//                break;
            case 4:{
                CouponsViewController *coupons = [[CouponsViewController alloc] init];
                [self.navigationController pushViewController:coupons animated:YES];
            }
                break;
            case 5:{
                SetingViewController *coupons = [[SetingViewController alloc] init];
                [self.navigationController pushViewController:coupons animated:YES];
            }
                break;
            default:
                break;
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(SelfViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SelfViewModel alloc] init];
    }
    return _viewModel;
}

-(SelfView *)mainView {
    if (!_mainView) {
        _mainView = [[SelfView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
@end
