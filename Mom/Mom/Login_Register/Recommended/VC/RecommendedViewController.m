//
//  RecommendedViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "RecommendedViewController.h"
#import "RecommendedView.h"
#import "RecommendedViewModel.h"
#import "InformationViewController.h"

@interface RecommendedViewController ()
@property (strong, nonatomic) RecommendedView *mainView;
@property (strong, nonatomic) RecommendedViewModel *viewModel;
@end

@implementation RecommendedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"推荐人信息"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)viewDidLayoutSubviews {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)setModel:(LoginModel *)model {
    _model = model;
}

- (void)bindViewModel {
        @weakify(self)
        [[self.viewModel.bindReferrerSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
            @strongify(self)
//            InformationViewController *forget = [[InformationViewController alloc] init];
//            [self.navigationController pushViewController:forget animated:YES];
        }];
}

- (UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    [btn setTitle:@"跳过" forState:UIControlStateNormal];//设置左边按钮的图片
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(pass) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    [btn setImage:[UIImage imageNamed:@"NavigationBar_Back"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(backRoot) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)backRoot {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)pass {
    if ([self.model.userStatus intValue]==2) {
//        NannyCertificationViewController *nanny = [[NannyCertificationViewController alloc] init];
//        nanny.isFirst = YES;
//        [self.navigationController pushViewController:nanny animated:YES];
    }else {
        [self backRoot];
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

- (RecommendedView *)mainView {
    if (!_mainView) {
        _mainView = [[RecommendedView alloc] initWithViewModel:self.viewModel];
        _mainView.userInteractionEnabled = YES;
    }
    return _mainView;
}

- (RecommendedViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[RecommendedViewModel alloc] init];
    }
    return _viewModel;
}

@end
