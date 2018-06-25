//
//  DemandViewController.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "DemandViewController.h"
#import "DemandTableViewCell.h"
#import "SendDemandViewController.h"
#import "DemandViewModel.h"
#import "DemandDetailsViewController.h"
#import "NannyCardViewController.h"

@interface DemandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) DemandViewModel *viewModel;
@end

@implementation DemandViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"找月嫂";
    self.table.delegate = self;
    self.table.dataSource = self;
    if (@available(iOS 11.0, *)) {
        _table.estimatedRowHeight = 0;
        _table.estimatedSectionFooterHeight = 0;
        _table.estimatedSectionHeaderHeight = 0;
        _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self.table registerNib:[UINib nibWithNibName:@"DemandTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DemandTableViewCell class])]];
    @weakify(self)
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel.dataArray removeAllObjects];
        [self.viewModel.getCouponsCommand execute:@{@"pageNo":@"0",@"pageSize":@"10"}];
    }];
    self.table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        @strongify(self)
        [self.viewModel.getCouponsCommand execute:@{@"pageNo":@(self.viewModel.dataArray.count),@"pageSize":@"10"}];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.table reloadData];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getCouponsCommand execute:@{@"pageNo":@"0",@"pageSize":@"10"}];
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        if (self.table.mj_header.state == MJRefreshStateRefreshing) {
            [self.table.mj_header endRefreshing];
        }
        if (self.table.mj_footer.state == MJRefreshStateRefreshing) {
            [self.table.mj_footer endRefreshing];
        }
        [self.table reloadData];
    }];
}

- (UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:@"发布需求" forState:UIControlStateNormal];//设置左边按钮的图片
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(sendDemand) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)sendDemand {
    
    SendDemandViewController *sendDemand = [[SendDemandViewController alloc] init];
    @weakify(self)
    sendDemand.refreshBlock = ^{
     @strongify(self)
        [self.viewModel.dataArray removeAllObjects];
        [self.viewModel.getCouponsCommand execute:@{@"pageNo":@"0",@"pageSize":@"10"}];
    };
    [self.navigationController pushViewController:sendDemand animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemandTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([DemandTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DemandDetailsViewController *demandDetails = [[DemandDetailsViewController alloc] init];
    demandDetails.model = self.viewModel.dataArray[indexPath.row];
    [self.navigationController pushViewController:demandDetails animated:YES];
}

- (DemandViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[DemandViewModel alloc] init];
    }
    return _viewModel;
}
@end
