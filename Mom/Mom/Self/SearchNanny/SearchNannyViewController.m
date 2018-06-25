//
//  SearchNannyViewController.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SearchNannyViewController.h"
#import "SearchNannyFootView.h"
#import "SearchNannyView.h"
#import "SearchNannyTableViewCell.h"
#import "AddNannyViewController.h"
#import "SearchNannyViewModel.h"

@interface SearchNannyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) SearchNannyView *headView;
@property (strong, nonatomic) SearchNannyFootView *footView;
@property (strong, nonatomic) SearchNannyViewModel *viewModel;
@end

@implementation SearchNannyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"搜索护理师"];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableHeaderView = self.headView;
    self.table.tableFooterView = self.footView;
    [self.table registerNib:[UINib nibWithNibName:@"SearchNannyTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([SearchNannyTableViewCell class])]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self.table reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataarray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SearchNannyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([SearchNannyTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataarray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    AddNannyViewController *addNanny = [[AddNannyViewController alloc] init];
    addNanny.model = self.viewModel.dataarray[indexPath.row];
    [self.navigationController pushViewController:addNanny animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (SearchNannyView *)headView {
    if (!_headView) {
        _headView = [[SearchNannyView alloc] initWithViewModel:self.viewModel];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 60);
    }
    return _headView;
}

- (SearchNannyFootView *)footView {
    if (!_footView) {
        _footView = [[SearchNannyFootView alloc] initWithViewModel:self.viewModel];
        _footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 200);
    }
    return _footView;
}

- (SearchNannyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SearchNannyViewModel alloc] init];
    }
    return _viewModel;
}
@end
