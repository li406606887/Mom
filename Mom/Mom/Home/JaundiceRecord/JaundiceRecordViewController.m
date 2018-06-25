//
//  JaundiceRecordViewController.m
//  Mom
//
//  Created by together on 2018/5/30.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "JaundiceRecordViewController.h"
#import "JaundiceTableViewCell.h"
#import "JaundiceRecordViewModel.h"

@interface JaundiceRecordViewController ()
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) JaundiceRecordViewModel *viewModel;
@end

@implementation JaundiceRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"全部记录"];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerNib:[UINib nibWithNibName:@"JaundiceTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([JaundiceTableViewCell class])]];
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

- (void)setModel:(BabyModel *)model {
    _model = model;
    [self.viewModel.getCurrentRecordCommand execute:@{@"babyId":model.ID,@"offset":@"0",@"limit":@"10"}];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = RGB(255, 212, 60);
    NSArray *titleArray = @[@"观测时间",@"观测人员",@"宝宝",@"黄疸值"];
    for (int i = 0; i<4; i++) {
        UILabel *title = [[UILabel alloc] init];
        title.text = titleArray[i];
        title.font = [UIFont systemFontOfSize:14];
        title.textAlignment = NSTextAlignmentCenter;
        [title setFrame:CGRectMake((SCREEN_WIDTH-30)*0.25*i +15, 0, (SCREEN_WIDTH-30)*0.25, 50)];
        [view addSubview:title];
    }
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JaundiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([JaundiceTableViewCell class])] forIndexPath:indexPath];
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
- (JaundiceRecordViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JaundiceRecordViewModel alloc] init];
    }
    return _viewModel;
}
@end
