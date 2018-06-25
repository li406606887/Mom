//
//  MyWelfareViewController.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyWelfareViewController.h"
#import "MyWelfareViewModel.h"
#import "MyWelfareTableViewCell.h"

@interface MyWelfareViewController ()
@property (strong, nonatomic) MyWelfareViewModel *viewModel;
@end

@implementation MyWelfareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"我的福利"];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerNib:[UINib nibWithNibName:@"MyWelfareTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyWelfareTableViewCell class])]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getMyWelfareCommand execute:nil];
    [self.viewModel.getMyWelfareSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyWelfareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyWelfareTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
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
- (MyWelfareViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyWelfareViewModel alloc] init];
    }
    return _viewModel;
}
@end
