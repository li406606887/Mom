//
//  MyBabyViewController.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyBabyViewController.h"
#import "MyBabyTableViewCell.h"
#import "AddBabyViewController.h"
#import "MyBabbyViewModel.h"

@interface MyBabyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) MyBabbyViewModel *viewModel;
@end

@implementation MyBabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"我的宝宝";
    self.table.delegate = self;
    self.table.dataSource = self;
    @weakify(self)
    self.table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
     @strongify(self)
        [self.viewModel.dataArray removeAllObjects];
        [self.viewModel.getMyBabyCommand execute:nil];
    }];
    self.table.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.table registerNib:[UINib nibWithNibName:@"MyBabyTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyBabyTableViewCell class])]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.viewModel.getMyBabyCommand execute:nil];
}

- (UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitle:@"添加" forState:UIControlStateNormal];//设置左边按钮的图片
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(addBaby) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)addBaby {
    AddBabyViewController *addBaby = [[AddBabyViewController alloc] init];
    [self.navigationController pushViewController:addBaby animated:YES];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table.mj_header endRefreshing];
        [self.table reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyBabyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyBabyTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.state == 1) {
        if (self.clickBlock) {
            self.clickBlock(self.viewModel.dataArray[indexPath.row]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }else {
        AddBabyViewController *addBaby = [[AddBabyViewController alloc] init];
        addBaby.model = self.viewModel.dataArray[indexPath.row];
        [self.navigationController pushViewController:addBaby animated:YES];
    }
}

- (void)setState:(int)state {
    _state = state;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (MyBabbyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyBabbyViewModel alloc] init];
    }
    return _viewModel;
}
@end
