//
//  YLAddBankMainView.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLAddBankMainView.h"
#import "YLAddBankViewModel.h"
#import "YLAddBankCardTextfieldCell.h"
#import "YLFillInfoCreatTableModel.h"
#import "BankSheetModel.h"
#import "YiGeSheetView.h"

@interface YLAddBankMainView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UITableView  *tableView;
@property (nonatomic,strong) YLAddBankViewModel *viewModel;
@property (nonatomic,strong) UIView *footView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) NSMutableDictionary *formDict;

@property (nonatomic,strong) NSMutableArray  *bankTempArray;

@end

@implementation YLAddBankMainView


-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLAddBankViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {
    WS(weakSelf)
    [self.viewModel.bankCardBinCommand.executionSignals.switchToLatest subscribeNext:^(NSArray *  _Nullable x) {

        NSMutableArray * temp = [NSMutableArray array];
        for (NSDictionary * dic in x) {
            BankSheetModel * model = [BankSheetModel mj_objectWithKeyValues:dic];
            [temp  addObject:model];
        }
        weakSelf.bankTempArray = temp;
        
    }];
    
}
-(NSMutableArray *)bankTempArray {
    if (!_bankTempArray) {
        _bankTempArray = [NSMutableArray array];
    }
    return _bankTempArray;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
    
    YLFillInfoCreatTableModel *model = self.dataArray[indexPath.row];
    

    static NSString *cellID = @"YLAddBankCardTextfieldCell";
    YLAddBankCardTextfieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[YLAddBankCardTextfieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //监听textField输入
        [cell textFieldAddObserver:self selector:@selector(textFieldValueChange:)];
    }
    
    cell.formDict = self.formDict;
    cell.creatTableModel = model;
//    WS(weakSelf)
    __weak typeof(cell) weakCell= cell;
    cell.clickBlock = ^(NSString *str) {
        YiGeSheetView * sheetView = [[YiGeSheetView alloc] initWithSortDataArray:self.bankTempArray];
        [sheetView show];
        sheetView.selcetBlock = ^(BankSheetModel *model) {
            [weakCell.formDict setValue:model.bankName forKey:weakCell.creatTableModel.key];
            weakCell.textField.text = model.bankName;
            [self.formDict setObject:model.bankLogo forKey:@"bankLogo"];
            [weakCell.textField resignFirstResponder];
        };
    };
    
    return cell;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
        YLFillInfoCreatTableModel *cardNum = [YLFillInfoCreatTableModel new];
        cardNum.title = @"银行卡号";
        cardNum.placeholder = @"请输入银行卡号";
        //提交到服务器的key
        cardNum.key = @"bankNo";
        [self.dataArray addObject:cardNum];
        
        YLFillInfoCreatTableModel *bankName = [YLFillInfoCreatTableModel new];
        bankName.title = @"银行名称";
        bankName.placeholder = @"请输入银行名称";
        //提交到服务器的key
        bankName.key = @"bankName";
        [self.dataArray addObject:bankName];
        
        YLFillInfoCreatTableModel *name = [YLFillInfoCreatTableModel new];
        name.title = @"用户姓名";
        name.placeholder = @"请输入用户姓名";
        //提交到服务器的key
        name.key = @"userName";
        [self.dataArray addObject:name];
        
        YLFillInfoCreatTableModel *idcard = [YLFillInfoCreatTableModel new];
        idcard.title = @"身份证号";
        idcard.placeholder = @"请输入身份证号";
        //提交到服务器的key
        idcard.key = @"idcard";
        [self.dataArray addObject:idcard];
        
        YLFillInfoCreatTableModel *phone = [YLFillInfoCreatTableModel new];
        phone.title = @"绑定手机";
        phone.placeholder = @"请输入绑定手机";
        //提交到服务器的key
        phone.key = @"phone";
        [self.dataArray addObject:phone];
        
        YLFillInfoCreatTableModel *branch = [YLFillInfoCreatTableModel new];
        branch.title = @"开户支行";
        branch.placeholder = @"开户支行";
        //提交到服务器的key
        branch.key = @"branch";
        [self.dataArray addObject:branch];
        
    }
    return _dataArray;
}
- (void)textFieldValueChange:(NSNotification *)note
{
    
    UITextField *textField = note.object;
    //可以这样取值
    NSString *bankNo = self.formDict[@"bankNo"];
    NSString *bankName = self.formDict[@"bankName"];
    NSString *idcard = self.formDict[@"idcard"];
    NSString *branch = self.formDict[@"branch"];
    
    NSLog(@"现在输入的是：%@\nbankNo = %@,\nbankName = %@,\nidcard = %@,\nbranch = %@,\n",textField.text,
          bankNo,
          bankName,
          idcard,
          branch);
    
}

//因为监听了textField通知，所以记得要在注销时，注销通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

-(void)commitBtnClick {
    
     NSLog(@"提交-》%@",self.formDict);
    
    [self.viewModel.commitCommand execute:self.formDict];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YLAddBankCardTextfieldCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([YLAddBankCardTextfieldCell class])]];
        
        self.footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        self.footView.backgroundColor = RGB(240, 240, 240);
        UIButton * commitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [commitBtn setTitle:@"添加银行卡" forState:UIControlStateNormal];
        [commitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        commitBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
        [commitBtn setBackgroundColor:RGB(255, 218, 68)];
        commitBtn.layer.cornerRadius = 5.0f;
        commitBtn.layer.masksToBounds = YES;
        [commitBtn addTarget:self  action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        [self.footView addSubview:commitBtn];
        [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.footView).offset(19);
            make.left.equalTo(self.footView).offset(15);
            make.right.equalTo(self.footView).offset(-15);
            make.height.mas_offset(45);
        }];
        
        [_tableView setTableFooterView:self.footView];
        
        _tableView.backgroundColor = RGB(240, 240, 240);
    }
    return _tableView;
}

-(void)setupViews {
    [self addSubview:self.tableView];
    self.formDict = [NSMutableDictionary dictionary];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}
- (YLAddBankViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLAddBankViewModel alloc] init];
    }
    return _viewModel;
}



@end
