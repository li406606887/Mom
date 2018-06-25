//
//  SelfView.m
//  FamilyFarm
//
//  Created by user on 2017/10/24.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "SelfView.h"
#import "SelfHeadView.h"
#import "SelfViewModel.h"
#import "SelfTableViewCell.h"

@interface SelfView()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
@property(nonatomic,strong) SelfHeadView *headView;
@property(nonatomic,strong) SelfViewModel *viewModel;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,strong) NSArray *detailsArray;
@property(nonatomic,strong) NSArray *imageArray;
@end

@implementation SelfView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (SelfViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}

# pragma mark table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelfTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([SelfTableViewCell class])] forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.title.text = self.titleArray[indexPath.row];
    cell.detailsTitle.text = self.detailsArray[indexPath.row];
    cell.icon.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.selfItemClickSubject sendNext:@(indexPath.row)];
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
        [_table registerClass:[SelfTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([SelfTableViewCell class])]];
    }
    return _table;
}

-(SelfHeadView *)headView {
    if (!_headView) {
        _headView = [[SelfHeadView alloc] initWithViewModel:self.viewModel];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 110);
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
//        @weakify(self)
//        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
//            @strongify(self)
//            [self.viewModel.headIconClickSubject sendNext:nil];
//        }];
//        [_headView addGestureRecognizer:tap];
    }
    return _headView;
}

-(NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"钱包",@"我的宝宝",@"我的月嫂",@"找月嫂",@"我的大礼包",@"设置",nil];//,@"我的奖励"
    }
    return _titleArray;
}
- (NSArray *)detailsArray {
    if (!_detailsArray) {
        _detailsArray = [NSArray arrayWithObjects:@"提供余额、首付款、银行卡、微信、支付宝绑定等金融服务",@"我的宝宝管理",@"提供收藏月嫂，服务的月嫂等",@"提供发布护理需求",@"提供平台发放的优惠券信息",@"提供登录密码设置，支付密码设置等功能", nil];//,@"提供平台发放的福利"
    }
    return _detailsArray;
}

- (NSArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [NSArray arrayWithObjects:@"Self_Wallet",@"self_my_baby",@"self_my_nanny",@"Self_Service",@"self_mycoupons",@"Self_Seting", nil];//,@"Self_Welfare"
    }
    return _imageArray;
}
@end
