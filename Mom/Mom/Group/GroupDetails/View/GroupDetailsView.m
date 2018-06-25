//
//  GroupDetailsView.m
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "GroupDetailsView.h"
#import "AnswerModel.h"

@implementation GroupDetailsView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (GroupDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.toolView];
    [self addSubview:self.table];
}

-(void)layoutSubviews {
    [self.toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self);
        make.bottom.equalTo(self.toolView.mas_top);
        make.width.offset(SCREEN_WIDTH);
    }];
    [super layoutSubviews];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.dataArray removeAllObjects];
    [self.viewModel.getDetailsCommand execute:@{@"circleId":self.viewModel.model.ID,@"offset":@"0",@"limit":@"10"}];
    [self.viewModel.refreshSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.table.mj_footer endRefreshing];
        [self.table reloadData];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.dataArray.count;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *headTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    [headTitle setFont:[UIFont systemFontOfSize:16]];
    headTitle.text = @"    全部评论";
    headTitle.textColor = RGB(200, 200, 200);
    headTitle.backgroundColor = [UIColor whiteColor];
    return headTitle;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerModel *model = self.viewModel.dataArray[indexPath.row];
    return model.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([GroupDetailsTableViewCell class])] forIndexPath:indexPath];
    cell.model = self.viewModel.dataArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
        _table.backgroundColor = RGB(242, 242, 242);
        _table.tableHeaderView = self.headView;
        if (@available(iOS 11.0, *)) {
            _table.estimatedRowHeight = 0;
            _table.estimatedSectionFooterHeight = 0;
            _table.estimatedSectionHeaderHeight = 0;
            _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        @weakify(self)
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.getDetailsCommand execute:@{@"offset":@(self.viewModel.dataArray.count),@"circleId":self.viewModel.model.ID,@"limit":@"10"}];
        }];
        [_table registerClass:[GroupDetailsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([GroupDetailsTableViewCell class])]];
    }
    return _table;
}

-(GroupDetailsToolView *)toolView {
    if (!_toolView) {
        _toolView = [[GroupDetailsToolView alloc] initWithViewModel:self.viewModel];
        _toolView.backgroundColor = [UIColor whiteColor];
    }
    return _toolView;
}

- (GroupDetailsHeadView *)headView {
    if (!_headView) {
        _headView = [[GroupDetailsHeadView alloc] initWithViewModel:self.viewModel];
        _headView.frame = CGRectMake(0,0,SCREEN_WIDTH, self.viewModel.model.headHeight);

    }
    return _headView;
}
@end
