//
//  GroupViewController.m
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "GroupViewController.h"
#import "GroupView.h"
#import "GroupViewModel.h"
#import "ShoppingCartViewController.h"
#import "GroupDetailsViewController.h"
#import "PublishShareViewController.h"

@interface GroupViewController ()
@property(nonatomic,strong) GroupView * mainView;
@property(nonatomic,strong) GroupViewModel *viewModel;
@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"圈子"];
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

-(UIBarButtonItem *)rightButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setFrame:CGRectMake(0, 0, 60, 30)];
    [button setTitle:@"提问" forState:UIControlStateNormal];
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self pushDetailsViewController];
    }];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    return item;
}

- (void)bindViewModel {
    @weakify(self)
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        GroupDetailsViewController *details = [[GroupDetailsViewController alloc] init];
        details.model = (GroupModel *)x;
        [self.navigationController pushViewController:details animated:YES];
    }];
}
- (void)pushDetailsViewController {
    @weakify(self)
    PublishShareViewController *publish = [[PublishShareViewController alloc] init];
    publish.refreshBlock = ^{
        @strongify(self)
        [self.viewModel.squareArray removeAllObjects];
        [self.viewModel.getSquareCommand execute:@{@"offset":@"0",@"limit":@"10"}];
    };
    [self.navigationController pushViewController:publish animated:YES];
}
/*
#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(GroupView *)mainView {
    if (!_mainView) {
        _mainView = [[GroupView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}

-(GroupViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GroupViewModel alloc] init];
    }
    return _viewModel;
}
@end
