//
//  GroupView.m
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "GroupView.h"
#import "GroupViewModel.h"
#import "GroupTableViewCell.h"
#import "SegmentedScrollView.h"
#import "GroupModel.h"
#import "SquareHeadView.h"

@interface GroupView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) GroupViewModel *viewModel;
@property(nonatomic,strong) UITableView *topTable;//置顶
@property(nonatomic,strong) UITableView *squareTable;//广场
@property(nonatomic,copy) UITableView *displayedTable;//广场
@property(strong, nonatomic) SegmentedScrollView *segmentedView;
@property(strong, nonatomic) SquareHeadView *headView;
@end

@implementation GroupView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (GroupViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.segmentedView];
    _displayedTable = self.topTable;
    [self addSubview:self.displayedTable];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)layoutSubviews {
    [self.displayedTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(44, 0, 0, 0));
    }];
    [super layoutSubviews];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getTopCommand execute:@{@"offset":@"0",@"limit":@"10"}];
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.displayedTable.mj_header endRefreshing];
        [self.displayedTable.mj_footer endRefreshing];
        [self.displayedTable reloadData];
    }];
}

# pragma mark collectionView代理事件
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.displayedTable == self.topTable ? self.viewModel.topArray.count:self.viewModel.squareArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupModel *model = self.displayedTable == self.topTable ? self.viewModel.topArray[indexPath.row] :self.viewModel.squareArray[indexPath.row];
    return model.height;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([GroupTableViewCell class])] forIndexPath:indexPath];
    GroupModel *model = self.displayedTable == self.topTable ? self.viewModel.topArray[indexPath.row] :self.viewModel.squareArray[indexPath.row];
    cell.model = model;
    @weakify(self)
    cell.btnClickBlock = ^(int index) {
     @strongify(self)
        [self gotoRefreshUI:index row:(int)indexPath.row];
    };
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    GroupModel *model = self.displayedTable == self.topTable ? self.viewModel.topArray[indexPath.row] :self.viewModel.squareArray[indexPath.row];
    [self.viewModel.cellClickSubject sendNext:model];
}

- (void)gotoRefreshUI:(int)index row:(int )row {
    GroupModel *model = self.displayedTable == self.topTable ? self.viewModel.topArray[row] :self.viewModel.squareArray[row];
    self.viewModel.selectedModel = model;
    switch (index) {
        case 0:{
            if ([model.isCollect intValue] == 1) {
                [self.viewModel.cancelCollectCommand execute:@{@"circleId":model.ID}];
            } else {
                [self.viewModel.collectCommand execute:@{@"circleId":model.ID}];
            }
        }
            break;
        case 1:{
            if ([model.isAttention intValue] == 1) {
                [self.viewModel.cancelConcernCommand execute:@{@"circleId":model.ID}];
            } else {
                [self.viewModel.concernCommand execute:@{@"circleId":model.ID}];
            }
        }
            break;
            
        default:
            break;
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UITableView *)topTable {
    if (!_topTable) {
        _topTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _topTable.delegate = self;
        _topTable.dataSource = self;
        _topTable.backgroundColor = RGB(242, 242, 242);
        UILabel *headTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        [headTitle setFont:[UIFont systemFontOfSize:16]];
        headTitle.text = @"    问题列表";
        _topTable.tableHeaderView = headTitle;
        _topTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        @weakify(self)
        _topTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
           @strongify(self)
            [self.viewModel.topArray removeAllObjects];
            [self.viewModel.getTopCommand execute:@{@"offset":@"0",@"limit":@"10"}];
        }];
        _topTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.getTopCommand execute:@{@"offset":@(self.viewModel.topArray.count),@"limit":@"10"}];
        }];
        [_topTable registerClass:[GroupTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([GroupTableViewCell class])]];
    }
    return _topTable;
}

- (UITableView *)squareTable {
    if (!_squareTable) {
        _squareTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _squareTable.delegate = self;
        _squareTable.dataSource = self;
        _squareTable.backgroundColor = RGB(242, 242, 242);
        _squareTable.tableHeaderView = self.headView;
        _squareTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        @weakify(self)
        _squareTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.squareArray removeAllObjects];
            [self.viewModel.getSquareCommand execute:@{@"offset":@"0",@"limit":@"10"}];
        }];
         _squareTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.getSquareCommand execute:@{@"offset":@(self.viewModel.topArray.count),@"limit":@"10"}];
        }];
        [_squareTable registerClass:[GroupTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([GroupTableViewCell class])]];
    }
    return _squareTable;
}

- (SegmentedScrollView *)segmentedView {
    if (!_segmentedView) {
        _segmentedView = [[SegmentedScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44) item:@[@"置顶",@"孕妈育儿圈广场"]];
        _segmentedView.backgroundColor = [UIColor whiteColor];
        _segmentedView.defultTitleColor = [UIColor darkGrayColor];
        _segmentedView.selectedTitleColor = [UIColor blackColor];
        _segmentedView.lineColor = RGB(254, 212, 54);
        _segmentedView.font = 14;
        @weakify(self)
        _segmentedView.itemClick = ^(int index) {
         @strongify(self)
            NSLog(@"%d",index);
            [self.displayedTable removeFromSuperview];
            switch (index) {
                case 0: {
                    _displayedTable = self.topTable;
                    [self addSubview:self.displayedTable];
                }
                    break;
                case 1:{
                    _displayedTable = self.squareTable;
                    if (self.viewModel.squareArray.count<1) {
                        [self.viewModel.getSquareCommand execute:@{@"offset":@"0",@"limit":@"10"}];
                    }
                    [self addSubview:self.displayedTable];
                }
                    break;
                default:
                    break;
            }
            [self.displayedTable reloadData];
        };
        [_segmentedView show];
    }
    return _segmentedView;
}

- (SquareHeadView *)headView {
    if (!_headView) {
        _headView  = [[SquareHeadView alloc] initWithViewModel:self.viewModel];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, (SCREEN_WIDTH/2.5)+40);
    }
    return _headView;
}
@end
