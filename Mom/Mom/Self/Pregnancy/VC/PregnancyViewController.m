//
//  PregnancyViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "PregnancyViewController.h"
#import "PregnancyViewModel.h"
#import "PregnancyView.h"

@interface PregnancyViewController ()
@property (strong, nonatomic) PregnancyViewModel *viewModel;
@property (strong, nonatomic) PregnancyView *mainView;
@end

@implementation PregnancyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"我怀孕了"];
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
        [[self.viewModel.saveDateSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
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

-(PregnancyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PregnancyViewModel alloc] init];
    }
    return _viewModel;
}

-(PregnancyView *)mainView {
    if (!_mainView) {
        _mainView = [[PregnancyView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
@end
