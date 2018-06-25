//
//  ServiceView.m
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "ServiceView.h"
#import "ServiceViewModel.h"
#import "ServiceView.h"
#import "ServiceSearchView.h"
#import "ServiceTableViewCell.h"

@interface ServiceView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) ServiceViewModel *viewModel;
@property(nonatomic,strong) ServiceSearchView *searchView;
@property(nonatomic,strong) UITableView *table;
@end

@implementation ServiceView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (ServiceViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCREEN_WIDTH*0.5+50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ServiceTableViewCell class])] forIndexPath:indexPath];
    
    return cell;
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
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _table.delegate = self;
        _table.dataSource = self;
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
        [headView addSubview:self.searchView];
        _table.tableHeaderView = headView;
        [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(headView);
        }];
        [_table registerClass:[ServiceTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ServiceTableViewCell class])]];
    }
    return _table;
}

-(ServiceSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[ServiceSearchView alloc] initWithViewModel:self.viewModel];
        _searchView.backgroundColor = [UIColor lightGrayColor];
        _searchView.title = @"sss";
    }
    return _searchView;
}
@end
