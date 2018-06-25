//
//  MyNannyDetailsViewController.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyNannyDetailsViewController.h"
#import "MyNannyDetailsView.h"
#import "EvaluationViewController.h"

@interface MyNannyDetailsViewController ()
@property (strong, nonatomic) MyNannyDetailsViewModel *viewModel;
@property (strong, nonatomic) MyNannyDetailsView *mainView;
@end

@implementation MyNannyDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.evaluationSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
//        EvaluationViewController *evaluation = [[EvaluationViewController alloc] init];
//         self.viewModel.model;
//        [self.navigationController pushViewController:evaluation animated:YES];
    }];
}

- (void)setModel:(NannyModel *)model {
    _model = model;
    self.viewModel.model = model;
    [self.viewModel.getOrderCommand execute:@{@"moonOrderId":model.ID}];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (MyNannyDetailsView *)mainView {
    if (!_mainView) {
        _mainView = [[MyNannyDetailsView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (MyNannyDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyNannyDetailsViewModel alloc] init];
    }
    return _viewModel;
}
@end
