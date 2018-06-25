//
//  MyNannyDetailsView.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyNannyDetailsView.h"

@implementation MyNannyDetailsView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MyNannyDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.table];
    [self setNeedsUpdateConstraints];
}

-(void)updateConstraints {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getOrderSuccessSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.table reloadData];
    }];
}
# pragma mark table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.viewModel.dataArray.count;
    }else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionArray[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 100;
    } else {
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyBabyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyBabyTableViewCell class])] forIndexPath:indexPath];
        cell.model = self.viewModel.dataArray[indexPath.row];
        return cell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyNannyDetailsCell" forIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor lightGrayColor];
    if (indexPath.row == 0) {
//        self.viewModel.model.moonId;
        cell.textLabel.text = @"妈妈评价";
    }else {
        cell.textLabel.text = @"月嫂评价";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        [self.viewModel.evaluationSubject sendNext:nil];
    }
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
        _table.tableHeaderView = self.headView;
        _table.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [_table registerNib:[UINib nibWithNibName:@"MyBabyTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyBabyTableViewCell class])]];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"MyNannyDetailsCell"];
    }
    return _table;
}

-(MyNannyDetailsHeadView *)headView {
    if (!_headView) {
        _headView = [[MyNannyDetailsHeadView alloc] initWithViewModel:self.viewModel];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
    }
    return _headView;
}

- (NSArray *)sectionArray {
    if (!_sectionArray) {
        _sectionArray = [NSArray arrayWithObjects:@"护理宝宝",@"妈妈评价",@"月嫂评价", nil];
    }
    return _sectionArray;
}
@end
