//
//  FriendsCircleDetailsView.m
//  FamilyFarm
//
//  Created by user on 2017/10/31.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "FriendsCircleDetailsView.h"
#import "FriendsCircleDetailsViewModel.h"
#import "FriendsCircleDetailsTableViewCell.h"
#import "FriendsCircleDetailsHeadView.h"


@interface FriendsCircleDetailsView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) FriendsCircleDetailsViewModel *viewModel;
@property(nonatomic,strong) FriendsCircleDetailsHeadView *headView;
@end

@implementation FriendsCircleDetailsView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (FriendsCircleDetailsViewModel *)viewModel;
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsCircleDetailsTableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FriendsCircleDetailsTableViewCell class])] forIndexPath:indexPath];
    
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
        _table.dataSource = self;
        _table.delegate = self;
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 500)];
        [view addSubview:self.headView];
        _table.tableHeaderView = view;
        [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(view);
        }];
        [_table registerClass:[FriendsCircleDetailsTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FriendsCircleDetailsTableViewCell class])]];
    }
    return _table;
}

-(FriendsCircleDetailsHeadView *)headView {
    if (!_headView) {
        _headView = [[FriendsCircleDetailsHeadView alloc] initWithViewModel:self.viewModel];
    }
    return _headView;
}

@end
