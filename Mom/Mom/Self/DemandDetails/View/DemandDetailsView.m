//
//  DemandDetailsView.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "DemandDetailsView.h"
#import "DemandDetailsTableViewCell.h"


@implementation DemandDetailsView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (DemandDetailsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.table];
//    [self addSubview:self.allInvitation];
    [self updateConstraintsIfNeeded];
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    [super updateConstraints];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getDemandDetailsCommand execute:nil];
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.table reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    sectionView.backgroundColor = RGB(254, 212, 60);
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
    title.text = @"全部应聘";
    title.font = [UIFont systemFontOfSize:14];
    [sectionView addSubview:title];
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DemandDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([DemandDetailsTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    @weakify(self)
    cell.clickBlock = ^(DemandDetailsModel *model) {
     @strongify(self)
        if ([model.status intValue]==20) {
            [self.viewModel.inviteSuccessMoonCommand execute:@{@"demandId":model.demandId,@"moonId":model.moon.userId}];
        }else {
            [self.viewModel.getInviteMoonCommand execute:@{@"demandId":model.demandId,@"moonId":model.moon.userId}];
        }
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.cellClickSubject sendNext:self.viewModel.dataArray[indexPath.row]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.tableHeaderView = self.headView;
        [_table registerNib:[UINib nibWithNibName:@"DemandDetailsTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DemandDetailsTableViewCell class])]];
    }
    return _table;
}

- (DemandDetailsHeadView *)headView {
    if (!_headView) {
        _headView = [[DemandDetailsHeadView alloc] initWithViewModel:self.viewModel];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 210);
    }
    return _headView;
}

@end
