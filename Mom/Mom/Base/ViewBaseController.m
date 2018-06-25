//
//  ViewBaseController.m
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import "ViewBaseController.h"
@interface ViewBaseController ()
@end

@implementation ViewBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUpNavigationBar];
    self.view.backgroundColor= DEFAULT_BG_COLOR;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


- (void) setUpNavigationBar {
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationItem.leftBarButtonItem = self.navigationController.childViewControllers.count==1? [self mainLeftButton] : [self leftButton];//设置导航栏左边按钮
    
    self.navigationItem.rightBarButtonItem = [self rightButton];//设置导航栏右边按钮
    self.navigationItem.titleView = [self centerView];//设置titel
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = YES
    ;
}

- (UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [btn setImage:[UIImage imageNamed:@"NavigationBar_Back"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (UIBarButtonItem *)rightButton {
    return nil;
}

- (UIBarButtonItem *)mainLeftButton {
//    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"NavigationBar_Logo"]];
    return nil;
}
- (UIView *)centerView {
    return nil;
}

- (void)actionOnTouchBackButton:(UIButton*)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideTabbar:(BOOL)hidden {
    self.tabBarController.tabBar.hidden = hidden;//隐藏导航栏
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    ViewBaseController *vc = [super allocWithZone:zone];
    @weakify(vc);
    [[vc rac_signalForSelector:@selector(viewDidLoad)] subscribeNext:^(id x) {
        @strongify(vc)
        [vc addChildView];
        [vc bindViewModel];
    }];
    
    [[vc rac_signalForSelector:@selector(viewWillAppear:)] subscribeNext:^(id x) {
    
    }];
    return vc;
}

-(void)addChildView {
    
}

-(void)bindViewModel {
    
}

@end
