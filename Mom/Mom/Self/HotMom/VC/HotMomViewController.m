//
//  HotMomViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "HotMomViewController.h"
#import "HotMomViewModel.h"
#import "HotMomView.h"

@interface HotMomViewController ()
@property (strong, nonatomic) HotMomViewModel *viewModel;
@property (strong, nonatomic) HotMomView *mainView;
@end

@implementation HotMomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我是辣妈"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [[self.viewModel.saveBabySubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.navigationController popToRootViewControllerAnimated:YES];
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

-(HotMomViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HotMomViewModel alloc] init];
    }
    return _viewModel;
}
-(HotMomView *)mainView {
    if (!_mainView) {
        _mainView = [[HotMomView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
@end
