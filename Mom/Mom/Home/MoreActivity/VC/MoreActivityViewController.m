//
//  MoreActivityViewController.m
//  Mom
//
//  Created by together on 2018/6/7.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MoreActivityViewController.h"
#import "MoreActivityViewModel.h"
#import "FarmTableViewCell.h"

@interface MoreActivityViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) MoreActivityViewModel *viewModel;
@end

@implementation MoreActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"更多活动"];
    [self.view setBackgroundColor:RGB(242, 242, 242)];
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.table registerClass:[FarmTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FarmTableViewCell class])]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getProblemCommand execute:nil];
    [self.viewModel.refreshProblemSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table.mj_header endRefreshing];
        [self.table reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.problemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FarmTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.problemArray[indexPath.row];
    @weakify(self)
    cell.btnClickBlock = ^(FarmModel *model) {
        @strongify(self)
        [self.viewModel.joinActivityCommand execute:@{@"activityId":model.ID}];
    };
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
- (MoreActivityViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MoreActivityViewModel alloc] init];
    }
    return _viewModel;
}

@end
