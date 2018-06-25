//
//  InformationViewController.m
//  FamilyFarm
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "InformationViewController.h"
#import "InformationView.h"
#import "InformationViewModel.h"
#import "PwdLoginViewController.h"
#import "AddBabyViewController.h"
#import "PregnancyViewController.h"

@interface InformationViewController ()
@property (strong, nonatomic) InformationView *mainView;
@property (strong, nonatomic) InformationViewModel *viewModel;
@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我的资料"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)updateViewConstraints {
    [super updateViewConstraints];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.setIdentitySubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        switch ([x intValue]) {
            case 1: {
//                PregnancyViewController *pregnancy = [[PregnancyViewController alloc] init];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
            case 2: {
//                PregnancyViewController *pregnancy = [[PregnancyViewController alloc] init];
//                [self.navigationController pushViewController:pregnancy animated:YES];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
                break;
            case 3: {
                AddBabyViewController *hotMom = [[AddBabyViewController alloc] init];
                hotMom.state = 1;
                [self.navigationController pushViewController:hotMom animated:YES];
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
- (InformationView *)mainView {
    if (!_mainView) {
        _mainView = [[InformationView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (InformationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[InformationViewModel alloc] init];
    }
    return _viewModel;
}

@end
