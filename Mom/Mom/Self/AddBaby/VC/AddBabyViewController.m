//
//  AddBabyViewController.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "AddBabyViewController.h"
#import "AddBabyTableViewCell.h"
#import "AddBabyViewModel.h"
#import "CommonChooseView.h"

@interface AddBabyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) AddBabyViewModel *viewModel;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIButton *submit;
@property (strong, nonatomic) UITextField *name;
@property (strong, nonatomic) UITextField *sex;
@property (strong, nonatomic) UITextField *liveDate;
@property (strong, nonatomic) UITextField *role;
@end

@implementation AddBabyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加宝宝";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.table];
}

- (void)viewDidLayoutSubviews {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super viewDidLayoutSubviews];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.addBabySubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        if (self.state == 1) {
            [self.navigationController popToRootViewControllerAnimated:YES];
            return ;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddBabyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AddBabyTableViewCell class])] forIndexPath:indexPath];
    cell.field.userInteractionEnabled = NO;
    cell.textLabel.text = self.titleArray[indexPath.row];
    switch (indexPath.row) {
        case 0:
            cell.field.placeholder = @"请输入宝宝乳名";
            cell.field.userInteractionEnabled = YES;
            if (self.model) {
                cell.field.text = self.model.name;
            }
            self.name = cell.field;
            break;
        case 1:
            cell.field.placeholder = @"请选择宝宝性别";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (self.model) {
                switch ([self.model.babySex intValue]) {
                    case 1:
                        cell.field.text = @"男";
                        break;
                    case 2:
                        cell.field.text = @"女";
                        break;
                    case 3:
                        cell.field.text = @"未知";
                        break;
                        
                    default:
                        break;
                }
            }
            self.sex = cell.field;
            break;
        case 2:
            cell.field.placeholder = @"出生日期或预产期";
            if (self.model) {
                cell.field.text = [NSDate changeDateWithdate:self.model.babyBirthday];
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.liveDate = cell.field;
            break;
        case 3:
            cell.field.placeholder = @"请选择角色";
            cell.field.text = @"妈妈";
            if (self.model) {
                cell.field.text = self.model.relationShip;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            self.role = cell.field;
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    @weakify(self)
    switch (indexPath.row) {
        case 1: {
            CommonChooseView *chooseView = [[CommonChooseView alloc] initWithFrame:[UIScreen mainScreen].bounds array:@[@"男",@"女",]];
            chooseView.seletedDateBlock = ^(NSString *date) {
                @strongify(self)
                self.sex.text = date;
            };
            [[UIApplication sharedApplication].keyWindow addSubview:chooseView];

        }
            break;
        case 2:{
            DatePickerView *date = [[DatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
            
            date.seletedDateBlock = ^(NSString *date) {
                @strongify(self)
                self.liveDate.text = date;
            };
            [[UIApplication sharedApplication].keyWindow addSubview:date];
        }
            break;
        case 3: {
            CommonChooseView *chooseView = [[CommonChooseView alloc] initWithFrame:[UIScreen mainScreen].bounds array:@[@"妈妈",@"爷爷",@"奶奶",@"外公",@"外婆"]];
            chooseView.seletedDateBlock = ^(NSString *date) {
                @strongify(self)
                self.role.text = date;
            };
            [[UIApplication sharedApplication].keyWindow addSubview:chooseView];
        }
            break;
        default:
            break;
    }
}
- (void)setModel:(BabyModel *)model {
    [self setTitle:@"修改宝宝"];
    _model = model;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [_table registerClass:[AddBabyTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AddBabyTableViewCell class])]];
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
        [footView addSubview:self.submit];
        [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(footView);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
        }];
        _table.tableFooterView = footView;
    }
    return _table;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"宝宝乳名",@"宝宝性别",@"生日/预产期",@"我的角色", nil];
    }
    return _titleArray;
}

- (UIButton *)submit {
    if (!_submit) {
        _submit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submit setTitle:@"保 存" forState:UIControlStateNormal];
        [_submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_submit.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _submit.backgroundColor = RGB(254, 212, 60);
        @weakify(self)
        [[_submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            if (self.name.text.length<1) {
                showMassage(@"请输入宝宝乳名");
                return ;
            }
            if (self.sex.text.length<1) {
                showMassage(@"请选择宝宝性别");
                return ;
            }
            if (self.liveDate.text.length<1) {
                showMassage(@"请输入出生日期或预产期");
                return ;
            }
           
            NSString *babySex;
            if ([self.sex.text isEqualToString:@"男"]) {
                babySex = @"1";
            }else if([self.sex.text isEqualToString:@"女"]){
                babySex = @"2";
            }else {
                babySex = @"3";
            }
            if (self.model) {
                [self.viewModel.addBabyCommand execute:@{@"babyId":self.model.ID,@"name":self.name.text,@"babyBirthday":self.liveDate.text,@"relationShip":self.role.text,@"babySex":babySex,@"babyBirthplace":@""}];
            }else {
                [self.viewModel.addBabyCommand execute:@{@"name":self.name.text,@"babyBirthday":self.liveDate.text,@"relationShip":self.role.text,@"babySex":babySex,@"babyBirthplace":@""}];
            }
        }];
    }
    return _submit;
}

-(AddBabyViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel  = [[AddBabyViewModel alloc] init];
    }
    return _viewModel;
}
@end
