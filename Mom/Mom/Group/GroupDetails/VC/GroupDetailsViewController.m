//
//  GroupDetailsViewController.m
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import "GroupDetailsView.h"
#import "GroupDetailsViewModel.h"

@interface GroupDetailsViewController ()
@property (strong, nonatomic) GroupDetailsViewModel *viewModel;
@property (strong, nonatomic) GroupDetailsView *mainView;
@end

@implementation GroupDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

- (void)setModel:(GroupModel *)model {
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
-(GroupDetailsView *)mainView {
    if (!_mainView) {
        _mainView = [[GroupDetailsView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

-(GroupDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GroupDetailsViewModel alloc] init];
    }
    return _viewModel;
}
@end
