//
//  GetCouponViewController.m
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "GetCouponViewController.h"
#import "GetCouponViewModel.h"
#import "GetCouponTableViewCell.h"
#import "CouponsDetailsViewController.h"

@interface GetCouponViewController ()
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) GetCouponViewModel *viewModel;
@end


@implementation GetCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"优惠券";
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews {
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super viewDidLayoutSubviews];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getCouponsListCommand execute:@{@"offset":@"0",@"limit":@"10",@"enabled":@"1"}];
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
            [self.tableView.mj_header endRefreshing];
        }
        if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
            [self.tableView.mj_footer endRefreshing];
        }
        [self.tableView reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.5f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GetCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([GetCouponTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    @weakify(self)
    cell.receiveBlock = ^(CouponsModel *model) {
        @strongify(self)
        [self.viewModel.getCouponsCommand execute:@{@"couponId":model.ID}];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CouponsDetailsViewController *details = [[CouponsDetailsViewController alloc] init];
    details.model = self.viewModel.dataArray[indexPath.row];
    [self.navigationController pushViewController:details animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = RGB(242, 242, 242);
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        @weakify(self)
        [_tableView registerNib:[UINib nibWithNibName:@"GetCouponTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([GetCouponTableViewCell class])]];
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.dataArray removeAllObjects];
            [self.viewModel.getCouponsListCommand execute:@{@"offset":@"0",@"limit":@"10"}];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.getCouponsListCommand execute:@{@"offset":@(self.viewModel.dataArray.count),@"limit":@"10"}];
        }];
        
    }
    return _tableView;
}
- (GetCouponViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[GetCouponViewModel alloc] init];
    }
    return _viewModel;
}
- (UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [btn setImage:[UIImage imageNamed:@"NavigationBar_Back"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


- (void)actionOnTouchBackButton:(UIButton*)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
