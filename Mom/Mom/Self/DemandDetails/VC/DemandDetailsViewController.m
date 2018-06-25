//
//  DemandDetailsViewController.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "DemandDetailsViewController.h"
#import "DemandDetailsViewModel.h"
#import "DemandDetailsView.h"
#import "EvaluationViewController.h"
#import "NannyCardViewController.h"

@interface DemandDetailsViewController ()
@property (strong, nonatomic) DemandDetailsViewModel *viewModel;
@property (strong, nonatomic) DemandDetailsView *mainView;
@end

@implementation DemandDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"护理详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.cellClickSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        NannyCardViewController *nanny = [[NannyCardViewController alloc] init];
        [self.navigationController pushViewController:nanny animated:YES];
    }];
    
}
- (void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)setModel:(DemandModel *)model {
    _model = model;
    self.viewModel.model = model;
    [self.view addSubview:self.mainView];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(DemandDetailsView *)mainView {
    if (!_mainView) {
        _mainView = [[DemandDetailsView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

-(DemandDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[DemandDetailsViewModel alloc] init];
    }
    return _viewModel;
}

@end
