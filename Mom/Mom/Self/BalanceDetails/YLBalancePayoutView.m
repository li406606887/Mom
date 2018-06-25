//
//  YLBalancePayoutView.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLBalancePayoutView.h"
#import "YLBalanceDetailsViewModel.h"
#import "YLBalanceDetailsCell.h"

@interface YLBalancePayoutView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) YLBalanceDetailsViewModel *viewModel;
@property (nonatomic,strong) UIView *headView;

@property (nonatomic,assign) int page;
@end

@implementation YLBalancePayoutView


-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLBalanceDetailsViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}

-(void)bindViewModel {
    
    [self.viewModel.refreshUI subscribeNext:^(id x) {
        
        [self.tableView reloadData];
    }];
    
    
    [self.viewModel.refreshEndSubject subscribeNext:^(id x) {
        
        [self.tableView reloadData];
        NSLog(@"shuaxin=%@",x);
        
        switch ([x integerValue]) {
            case HeaderRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                
                if (!self.tableView.mj_footer) {
                    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
                        //                        [self.viewModel.warehouseCommand execute:nil];
                    }];
                }
                
                break;
                
                
            case HeaderRefresh_HasNoMoreData:
                [self.tableView.mj_header endRefreshing];
                self.tableView.mj_footer = nil;
                
                break;
                
            case FooterRefresh_HasMoreData:
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer resetNoMoreData];
                [self.tableView.mj_footer endRefreshing];
                
                break;
                
            case FooterRefresh_HasNoMoreData:
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
                
                break;
            case RefreshError:
                [self.tableView.mj_footer endRefreshing];
                [self.tableView.mj_header endRefreshing];
                break;
                
            default:
                break;
        }
    }];
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.outDataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLBalanceDetailsCell * cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([YLBalanceDetailsCell class])]];
    
    if (self.viewModel.outDataArray.count > indexPath.row){
        YLBalanceDetailsModel * model = [YLBalanceDetailsModel mj_objectWithKeyValues:self.viewModel.outDataArray[indexPath.row]];
        
        cell.model = model;
    }
    return cell;
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YLBalanceDetailsCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([YLBalanceDetailsCell class])]];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 10);
        [_tableView setTableHeaderView:self.headView];
        _tableView.backgroundColor = RGB(240, 240, 240);
        
//        @weakify(self)
//        _tableView.mj_header  = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//            @strongify(self)//上拉
//            self.page--;
//            if (self.page <= 0) self.page = 1;
//            //            [self requestDataList];
//        }];
//        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
//            @strongify(self)
//            self.page++;
//            //            [self requestDataList];
//        }];
        
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever ;
        }
    }
    return _tableView;
}
-(void)requestDataList {
    NSMutableDictionary * input = [NSMutableDictionary dictionary];
    [input setObject:@"0" forKey:@"offset"];
    [input setObject:@"100" forKey:@"limit"];
    [input setObject:@"2" forKey:@"type"];
    [self.viewModel.getOutDateCommand execute:input];
    
}
-(UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = RGB(240, 240, 240);
    }
    return _headView;
}
-(void)setupViews {
    self.page = 1;
    [self requestDataList];
    
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

- (YLBalanceDetailsViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLBalanceDetailsViewModel alloc] init];
    }
    return _viewModel;
}


@end

