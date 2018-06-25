#import "YLWalletMainView.h"
#import "YLWalletViewModel.h"
#import "YLWalletCell.h"
#import "YLWalletHeadView.h"

@interface YLWalletMainView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) YLWalletViewModel *viewModel;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) YLWalletHeadView *headView;
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *iconArr;
@end

@implementation YLWalletMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLWalletViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;//2
    }else return 2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * row;
    if (indexPath.section == 0) {
        row = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    }else {
        row = [NSString stringWithFormat:@"%ld",(long)indexPath.row+1];//+2
    }
    [self.viewModel.cellClickSubject sendNext:row];
    NSLog(@"cellclick->%@",row);
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    view.backgroundColor = RGB(240, 240, 240);
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLWalletCell * cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([YLWalletCell class])]];
    
    if (indexPath.section == 0) {//0 1
        cell.nameLabel.text = self.titleArr[indexPath.row];
        cell.imgView.image = [UIImage imageNamed:self.iconArr[indexPath.row]];
    }else {
        cell.nameLabel.text = self.titleArr[indexPath.row+1];//2
        cell.imgView.image = [UIImage imageNamed:self.iconArr[indexPath.row+1]];//2
    }
    return cell;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YLWalletCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([YLWalletCell class])]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 171);
        [_tableView setTableHeaderView:self.headView];
        
        _tableView.backgroundColor = RGB(240, 240, 240);
    }
    return _tableView;
}
-(NSArray *)iconArr {
    if (!_iconArr) {
//        _iconArr = [NSArray arrayWithObjects:@"self_recharge",@"self_balance",@"self_accountBinding",@"self_cardManage", nil];
        _iconArr = [NSArray arrayWithObjects:@"self_balance",@"self_accountBinding",@"self_cardManage", nil];
    }
    return _iconArr;
}
-(NSArray *)titleArr {
    if (!_titleArr) {
//        _titleArr = [NSArray arrayWithObjects:@"充值",@"余额明细",@"账户绑定",@"银行卡管理", nil];
        _titleArr = [NSArray arrayWithObjects:@"余额明细",@"账户绑定",@"银行卡管理", nil];
    }
    return _titleArr;
}

-(YLWalletHeadView *)headView {
    if (!_headView) {
        _headView = [[YLWalletHeadView alloc] initWithViewModel:self.viewModel];
        _headView.backgroundColor = RGB(255, 218, 68);
    }
    return _headView;
}
-(void)setupViews {
    [self.viewModel.getDateCommand execute:nil];
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
- (YLWalletViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLWalletViewModel alloc] init];
    }
    return _viewModel;
}

@end
