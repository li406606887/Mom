//
//  YLRechargeMainView.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//
#import "YLRechargeMainView.h"
#import "YLRechargeViewModel.h"
#import "YLRechargeFootView.h"
#import "YLRechargeWayCell.h"

@interface YLRechargeMainView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) YLRechargeViewModel *viewModel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) YLRechargeFootView *footView;
@property (nonatomic,strong) NSArray *iconArray;
@property (nonatomic,strong) NSArray *payArray;
@property (nonatomic,strong) NSArray *accountArray;

@end

@implementation YLRechargeMainView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLRechargeViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {
    
}
-(void)setUserModel:(UserDataModel *)userModel {
    if (userModel) {
        self.footView.userModel = userModel;
        self.accountArray = [NSArray arrayWithObjects:userModel.wechatAccount,userModel.alipayAccount, nil];
        [self.tableView reloadData];
        
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.rechargeType = (int)indexPath.row;
    NSLog(@"rechargeType--->%d",self.rechargeType);
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(240, 240, 240);
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(240, 240, 240);
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLRechargeWayCell * cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([YLRechargeWayCell class])]];
    cell.nameLabel.text = self.payArray[indexPath.row];
    cell.imgView.image = [UIImage imageNamed:self.iconArray[indexPath.row]];
    cell.rightLabel.text = self.accountArray[indexPath.row];
    return cell;
}
-(NSArray *)accountArray {
    if (!_accountArray) {
        _accountArray = @[@"0",@""];
    }
    return _accountArray;
}

-(NSArray *)payArray {
    if (!_payArray) {
        _payArray = @[@"微信支付",@"支付宝支付"];
    }
    return _payArray;
}
-(NSArray *)iconArray {
    if (!_iconArray) {
        _iconArray = @[@"self_weixin",@"self_zhifubao"];
    }
    return _iconArray;
}

-(YLRechargeFootView *)footView {
    if (!_footView) {
        _footView = [[YLRechargeFootView alloc] initWithViewModel:self.viewModel];
    }
    return _footView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YLRechargeWayCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([YLRechargeWayCell class])]];
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160 + 60);
        [_tableView setTableFooterView:self.footView];
        
        _tableView.backgroundColor = RGB(240, 240, 240);
    }
    return _tableView;
}
-(void)setupViews {
    self.rechargeType = -1;
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

- (YLRechargeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLRechargeViewModel alloc] init];
    }
    return _viewModel;
}

@end
