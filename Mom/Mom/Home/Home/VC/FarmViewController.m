//
//  FarmViewController.m
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//
#import "FarmViewController.h"
#import "FarmView.h"
#import "FarmViewModel.h"
#import "ERCodeScaningViewController.h"
#import "PlantingViewController.h"
#import "LoginViewController.h"
#import "MyWelfareViewController.h"
#import "ActivityViewController.h"
#import "SendDemandViewController.h"
#import "JaundiceObserViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AddNannyViewController.h"
#import "MoreActivityViewController.h"
#import "DemandViewController.h"

@interface FarmViewController ()
@property(nonatomic,strong) FarmViewModel *viewModel;
@property(nonatomic,strong) FarmView *mainView;
@end

@implementation FarmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.mainView.table reloadData];
    [self.viewModel.getCouponsCommand execute:@{@"offset":@"0",@"limit":@"10",@"enabled":@"1"}];
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

-(void)bindViewModel {
    @weakify(self)
    
    [self.viewModel.getMainCommand execute:nil];

    [self.viewModel.getProblemCommand execute:nil];

    [[self.viewModel.farmHeadItemClickSubject takeUntil:self.rac_willDeallocSignal]  subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        switch ([x intValue]) {
            case 0:{
                MyWelfareViewController *myWelfar = [[MyWelfareViewController alloc] init];
                [self.navigationController pushViewController:myWelfar animated:YES];
            }
                break;
                
            case 1:{
                [self pushFriendsCircle];
            }
                break;
            case 2:{
                JaundiceObserViewController *jaund = [[JaundiceObserViewController alloc] init];
                [self.navigationController pushViewController:jaund animated:YES];
                
            }
                break;
            case 3:{
                [self.viewModel.getDemandCommand execute:@{@"pageNo":@"0",@"pageSize":@"10"}];
            }
                break;
            default:
                break;
        }
    }];
    
    [[self.viewModel.clickTableSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        ActivityViewController *activity = [[ActivityViewController alloc] init];
        activity.model = (FarmModel *)x;
        [self.navigationController pushViewController:activity animated:YES];
    }];
    
    [[self.viewModel.moreTableSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        MoreActivityViewController *more = [[MoreActivityViewController alloc] init];
        [self.navigationController pushViewController:more animated:YES];
    }];
    
    [self.viewModel.getInfoCommand execute:nil];
    
    [self.viewModel.gotoDemandSubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        if ([x intValue]==1) {
            DemandViewController *demand = [[DemandViewController alloc] init];
            [self.navigationController pushViewController:demand animated:YES];
        }else{
            SendDemandViewController *sendMemand = [[SendDemandViewController alloc] init];
            [self.navigationController pushViewController:sendMemand animated:YES];
        }
    }];
}

-(void)pushPlanting{
    LoginViewController *friends = [[LoginViewController alloc] init];
    [self.navigationController pushViewController:friends animated:YES];
}

-(void)pushFriendsCircle {
    ERCodeScaningViewController *friendCircle = [[ERCodeScaningViewController alloc] init];
    [self QRCodeScanVC:friendCircle];
}
- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
}

-(UIView *)centerView {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"NavigationBar_Logo"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 100, 30);
    button.imageView.contentMode = UIViewContentModeScaleAspectFit;
    return button;
}

/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(FarmView *)mainView {
    if (!_mainView) {
        _mainView = [[FarmView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

-(FarmViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[FarmViewModel alloc] init];
    }
    return _viewModel;
}

@end
