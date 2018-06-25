//
//  AddNannyViewController.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "AddNannyViewController.h"
#import "AddNannyTableViewCell.h"
#import "AddBabyTableViewCell.h"
#import "ChooseBabyCell.h"
#import "AddBabyViewController.h"
#import "DatePickerView.h"
#import "AddNannyViewModel.h"

@interface AddNannyViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic)  UIButton *footBtn;
@property (strong, nonatomic) UITextField *startDate;
@property (strong, nonatomic) UITextField *stopDate;
@property (strong, nonatomic) AddNannyViewModel *viewModel;
@property (strong, nonatomic) NSMutableDictionary *selectedDic;
@end

@implementation AddNannyViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加护理师";
    self.table.delegate = self;
    self.table.dataSource = self;
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    [footView addSubview:self.footBtn];
    [self.footBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, 40));
    }];
    self.table.tableFooterView = footView;
    [self.table registerNib:[UINib nibWithNibName:@"AddNannyTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AddNannyTableViewCell class])]];
    [self.table registerNib:[UINib nibWithNibName:@"ChooseBabyCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ChooseBabyCell class])]];
    [self.table registerClass:[AddBabyTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AddBabyTableViewCell class])]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [self.viewModel.getMayBabyCommand execute:nil];
    [super viewWillAppear:animated];
}

- (UIBarButtonItem *)leftButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [btn setImage:[UIImage imageNamed:@"NavigationBar_Back"] forState:UIControlStateNormal];//设置左边按钮的图片
    [btn addTarget:self action:@selector(actionOnTouchBackButton:) forControlEvents:UIControlEventTouchUpInside];//设置按钮的点击事件
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)actionOnTouchBackButton:(UIButton*)sender {
    if (self.state==1) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.table reloadData];
    }];
    
    [self.viewModel.addOrderSuccessSubject subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self notifySuccess];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)setModel:(InvitationNannyModel *)model {
    _model = model;
    self.viewModel.model = model;
    [self.viewModel.refreshTableSubject sendNext:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return @"";
    }else if (section ==1){
        return @"选择需要护理的宝宝";
    }else {
        return @"护理需求";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section ==0) {
        return 80;
    } else if(indexPath.section == 1) {
        return 60;
    } else {
        return 50;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return 30;
    }else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 1) {
        return 40;
    }else {
        return 0.5f;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else if (section ==1){
        return self.viewModel.babyArray.count;
    }else {
        return 2;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 1) {
        UIButton *addbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addbtn setFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [addbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [addbtn setTitle:@"+" forState:UIControlStateNormal];
        [addbtn setBackgroundColor:[UIColor whiteColor]];
        [addbtn.titleLabel setFont:[UIFont systemFontOfSize:35]];
        @weakify(self)
        [[addbtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            AddBabyViewController *addBaby = [[AddBabyViewController alloc] init];
            [self.navigationController pushViewController:addBaby animated:YES];
        }];
        return addbtn;
    } else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:{
            AddNannyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AddNannyTableViewCell class])] forIndexPath:indexPath];
            cell.model = self.viewModel.model;
            return cell;
        }
            break;
        case 1:{
            ChooseBabyCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([ChooseBabyCell class])] forIndexPath:indexPath];
            cell.model = self.viewModel.babyArray[indexPath.row];
            cell.cellClickBlock = ^(BabyModel *model) {
                if ([self.selectedDic objectForKey:@(indexPath.row)] !=nil) {
                    [self.selectedDic removeObjectForKey:@(indexPath.row)];
                }else {
                    [self.selectedDic setObject:model forKey:@(indexPath.row)];
                }
            };
            return cell;
        }
            break;
        case 2:{
            switch (indexPath.row) {
                case 0:{
                    AddBabyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AddBabyTableViewCell class])] forIndexPath:indexPath];
                    cell.field.userInteractionEnabled = NO;
                    cell.field.placeholder = [NSDate getNowDate];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.titleLabel.text = @"开始护理时间";
                    self.startDate = cell.field;
                    return cell;
                }
                    break;
                case 1: {
                    AddBabyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AddBabyTableViewCell class])] forIndexPath:indexPath];
                    cell.field.userInteractionEnabled = NO;
                    cell.field.placeholder = [NSDate getNowDate];
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.titleLabel.text = @"结束护理时间";
                    self.stopDate = cell.field;
                    return cell;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        switch (indexPath.row) {
            case 0:{
                DatePickerView *chooseView = [[DatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                @weakify(self)
                chooseView.seletedDateBlock = ^(NSString *date) {
                    @strongify(self)
                    self.startDate.text = date;
                };
                [[UIApplication sharedApplication].keyWindow addSubview:chooseView];
            }
                break;
            case 1:{
                DatePickerView *chooseView = [[DatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                @weakify(self)
                chooseView.seletedDateBlock = ^(NSString *date) {
                    @strongify(self)
                    self.stopDate.text = date;
                };
                [[UIApplication sharedApplication].keyWindow addSubview:chooseView];
            }
                break;
            default:
                break;
        }
    }
}

- (UIButton *)footBtn {
    if (!_footBtn) {
        _footBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _footBtn.backgroundColor = RGB(254, 212, 60);
        [_footBtn setTitle:@"邀请护理" forState:UIControlStateNormal];
        [_footBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_footBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        @weakify(self)
        [[_footBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            if (self.selectedDic.count<1) {
                showMassage(@"请选择需要护理的宝宝");
                return ;
            }
            if (self.startDate.text.length<1) {
                showMassage(@"请选择开始护理时间");
                return;
            }
            if (self.stopDate.text.length<1) {
                showMassage(@"请选择结束护理时间");
                return;
            }
            NSString *babyId = @"";
            for (NSString* index in [self.selectedDic allKeys]) {
                BabyModel *model = [self.selectedDic objectForKey:index];
                if ([babyId isEqualToString:@""]) {
                    babyId = [NSString stringWithFormat:@"%@",model.ID];
                }else {
                    babyId = [NSString stringWithFormat:@"%@,%@",babyId,model.ID];
                }
            }
            NSString *start = [self.startDate.text stringByAppendingString:@" 00:00:00"];
            NSString *stop = [self.stopDate.text stringByAppendingString:@" 00:00:00"];
            NSDictionary *param = @{@"moonId":self.model.userId,@"startDate":start,@"endDate":stop,@"babies":babyId,@"remark":@""};
            [self.viewModel.addOrderCommand execute:param];
        }];
    }
    return _footBtn;
}

- (void)notifySuccess {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddNannySuccess" object:nil];
}

- (AddNannyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[AddNannyViewModel alloc] init];
    }
    return _viewModel;
}

- (NSMutableDictionary *)selectedDic {
    if (!_selectedDic) {
        _selectedDic = [NSMutableDictionary dictionary];
    }
    return _selectedDic;
}
@end
