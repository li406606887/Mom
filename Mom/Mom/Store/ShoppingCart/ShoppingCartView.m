//
//  ShoppingCartView.m
//  FamilyFarm
//
//  Created by user on 2017/10/30.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "ShoppingCartView.h"
#import "ShoppingCartViewModel.h"
#import "ShoppingCartTableViewCell.h"
#import "ShoppingCartHeadView.h"

@interface ShoppingCartView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) ShoppingCartViewModel *viewModel;
@property(nonatomic,strong) ShoppingCartHeadView *headView;
@end

@implementation ShoppingCartView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (ShoppingCartViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.headView];
    [self addSubview:self.table];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 60));
    }];
    
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(60, 0, 0, 0));
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ShoppingCartTableViewCell class])] forIndexPath:indexPath];
    
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
        [_table registerClass:[ShoppingCartTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ShoppingCartTableViewCell class])]];
    }
    return _table;
}

-(ShoppingCartHeadView *)headView {
    if (!_headView) {
        _headView = [[ShoppingCartHeadView alloc] initWithViewModel:self.viewModel];
    }
    return _headView;
}
@end
