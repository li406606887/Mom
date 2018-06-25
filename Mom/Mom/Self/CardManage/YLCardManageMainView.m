//
//  YLCardManageMainView.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLCardManageMainView.h"
#import "YLCardManageCell.h"
#import "YLCardManageViewModel.h"
#import "YLCardManageFootView.h"

@interface YLCardManageMainView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) YLCardManageViewModel *viewModel;
@property (nonatomic,strong) YLCardManageFootView *footView;
@property (nonatomic,strong) UITableView *tableView;


@end

@implementation YLCardManageMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLCardManageViewModel *)viewModel;
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
    return self.viewModel.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //点击cell 弹出alert 解除绑定
    YLCardManageModel * model = [YLCardManageModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
    [self.viewModel.cellClickSubject sendNext:model.idcard];
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
    YLCardManageCell * cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([YLCardManageCell class])]];
//
    if (self.viewModel.dataArray.count > indexPath.row){
        YLCardManageModel * model = [YLCardManageModel mj_objectWithKeyValues:self.viewModel.dataArray[indexPath.row]];
        
        cell.model = model;
    }
    return cell;
}



-(YLCardManageFootView *)footView {
    if (!_footView) {
        _footView = [[YLCardManageFootView alloc] initWithViewModel:self.viewModel];
    }
    return _footView;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YLCardManageCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([YLCardManageCell class])]];
        
        self.footView.frame = CGRectMake(0, 0, SCREEN_WIDTH,  66);
        [_tableView setTableFooterView:self.footView];
        
        _tableView.backgroundColor = RGB(240, 240, 240);
    }
    return _tableView;
}

-(void)setupViews {
    [self addSubview:self.tableView];
    [self.viewModel.getDataCommand execute:nil];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}
- (YLCardManageViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLCardManageViewModel alloc] init];
    }
    return _viewModel;
}


@end
