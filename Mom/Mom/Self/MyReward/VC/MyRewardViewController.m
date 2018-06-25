//
//  MyRewardViewController.m
//  Mom
//
//  Created by together on 2018/5/28.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyRewardViewController.h"
#import "MyRewardTableViewCell.h"
#import "MyRewardHeadView.h"
#import "MyRewardViewModel.h"

@interface MyRewardViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) MyRewardHeadView *headView;
@property (strong, nonatomic) MyRewardViewModel *viewModel;
@end

@implementation MyRewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"我的奖励"];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.tableHeaderView = self.headView;
    [self.table registerNib:[UINib nibWithNibName:@"MyRewardTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyRewardTableViewCell class])]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getMyRewardCommand execute:nil];
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.myRewardArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyRewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyRewardTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.myRewardArray[indexPath.row];
    return cell;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (MyRewardHeadView *)headView {
    if (!_headView) {
        _headView = [[MyRewardHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    }
    return _headView;
}

- (MyRewardViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyRewardViewModel alloc] init];
    }
    return _viewModel;
}
@end
