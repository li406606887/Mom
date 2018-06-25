//
//  GroupMoreViewController.m
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "GroupMoreViewController.h"
#import "GroupMoreViewModel.h"
#import "GroupMoreView.h"
#import "GroupDetailsViewController.h"

@interface GroupMoreViewController ()
@property (strong, nonatomic) GroupMoreView *mainView;
@property (strong, nonatomic) GroupMoreViewModel *viewModel;
@end

@implementation GroupMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.mainView];
}

- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        GroupDetailsViewController *details = [[GroupDetailsViewController alloc] init];
        [self.navigationController pushViewController:details animated:YES];
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
- (GroupMoreView *)mainView {
    if (!_mainView) {
        _mainView = [[GroupMoreView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

- (GroupMoreViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GroupMoreViewModel alloc] init];
    }
    return _viewModel;
}
@end
