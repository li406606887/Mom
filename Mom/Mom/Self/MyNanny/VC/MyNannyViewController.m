//
//  MyNannyViewController.m
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyNannyViewController.h"
#import "MyNannyTableViewCell.h"
#import "SearchNannyViewController.h"
#import "MyNannyViewModel.h"
#import "MyNannyDetailsViewController.h"
#import "PayMoneyViewController.h"

@interface MyNannyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) MyNannyViewModel *viewModel;
@end

@implementation MyNannyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"我的月嫂"];
    @weakify(self)
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"AddNannySuccess" object:nil] subscribeNext:^(NSNotification * _Nullable x) {
     @strongify(self)
        [self.viewModel.dataArray removeAllObjects];
        [self.viewModel.getCouponsCommand execute:@{@"pageNum":@"0",@"pageSize":@"10"}];
    }];
}

- (UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 28, 28)];
    [btn setTitle:@"添加" forState:UIControlStateNormal];//设置左边按钮的图片
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(addBaby) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)addBaby {
    SearchNannyViewController *addBaby = [[SearchNannyViewController alloc] init];
    [self.navigationController pushViewController:addBaby animated:YES];
}


- (void)addChildView {
    [self.view addSubview:self.table];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLayoutSubviews {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super viewDidLayoutSubviews];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getCouponsCommand execute:@{@"pageNum":@"0",@"pageSize":@"10"}];

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyNannyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyNannyTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    @weakify(self)
    cell.payClickBlock = ^(NannyModel *model) {
        @strongify(self)
        PayMoneyViewController *pay = [[PayMoneyViewController alloc] init];
        pay.model = model;
        [self.navigationController pushViewController:pay animated:YES];
    };
    cell.endClickBlock = ^(NannyModel *model) {
        @strongify(self)
//        self.viewModel.model = model;
        if ([model.status intValue]==60) {
            //评价
        } else if([model.status intValue]==70){//上户
            [self.viewModel.startOrderCommand execute:@{@"moonOrderId":model.ID}];
        } else if([model.status intValue]==80){//下户
            [self endOrder:model];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyNannyDetailsViewController *myNanny = [[MyNannyDetailsViewController alloc] init];
    myNanny.model = self.viewModel.dataArray[indexPath.row];
    [self.navigationController pushViewController:myNanny animated:YES];
}

- (void)endOrder:(NannyModel *)model {
    @weakify(self)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                   message:@"是否确定要下户"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
     @strongify(self)
        [self.viewModel.endOrderCommand execute:@{@"moonOrderId":model.ID}];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action1];
    [alert addAction:action2];
    [self presentViewController:alert animated:YES completion:nil];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.backgroundColor = RGB(242, 242, 242);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _table.estimatedRowHeight = 0;
            _table.estimatedSectionFooterHeight = 0;
            _table.estimatedSectionHeaderHeight = 0;
            _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        @weakify(self)
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.dataArray removeAllObjects];
            [self.viewModel.getCouponsCommand execute:@{@"pageNum":@"0",@"pageSize":@"10"}];
        }];
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.getCouponsCommand execute:@{@"pageNum":@(self.viewModel.dataArray.count),@"pageSize":@"10"}];
        }];
        [_table registerClass:[MyNannyTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyNannyTableViewCell class])]];
    }
    return _table;
}

- (MyNannyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyNannyViewModel alloc] init];
    }
    return _viewModel;
}

@end
