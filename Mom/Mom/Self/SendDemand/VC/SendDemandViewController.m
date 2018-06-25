//
//  SendDemandViewController.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SendDemandViewController.h"
#import "AddBabyTableViewCell.h"
#import "SendDemandViewModel.h"
#import "CommonChooseView.h"
#import "DataPickerView.h"
#import "DemandTableViewCell.h"
#import "ChooseCityView.h"

@interface SendDemandViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) NSArray *myInfoTitle;
@property (strong, nonatomic) NSArray *nannyTitle;
@property (strong, nonatomic) UIButton *submit;
@property (strong, nonatomic) SendDemandViewModel *viewModel;
@property (strong, nonatomic) UITextField *datefield;
@property (strong, nonatomic) UITextField *serviceDays;
@property (strong, nonatomic) UITextField *adressfield;
@property (strong, nonatomic) UITextField *agefield;
@property (strong, nonatomic) UITextField *homefield;
@property (strong, nonatomic) UITextField *expfield;
@property (copy, nonatomic) NSString *minAge;
@property (copy, nonatomic) NSString *maxAge;
@property (strong, nonatomic) NSArray *ageArray;
//@property (strong, nonatomic) NSArray *priceArray;
@end

@implementation SendDemandViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"添加需求";
    self.table.delegate = self;
    self.table.dataSource = self;
    self.table.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.table registerClass:[AddBabyTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([AddBabyTableViewCell class])]];
//    [self.table registerClass:[DemandCityChooseCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DemandCityChooseCell class])]];
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    [footView addSubview:self.submit];
    [self.submit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(footView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-40, 40));
    }];
    self.table.tableFooterView = footView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addChildView {
    [self.view addSubview:self.table];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        if (self.refreshBlock) {
            self.refreshBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)viewDidLayoutSubviews {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super viewDidLayoutSubviews];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.5f;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"您的信息";
    } else {
        return @"月嫂要求";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    } else {
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddBabyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([AddBabyTableViewCell class])] forIndexPath:indexPath];
    cell.field.userInteractionEnabled = NO;
    switch (indexPath.section ) {
        case 0: {
            cell.textLabel.text = self.myInfoTitle[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    cell.field.placeholder = @"请选择预选期";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    self.datefield = cell.field;
                    break;
                case 1:
                    cell.field.placeholder = @"请输入服务的天数";
                    cell.field.keyboardType = UIKeyboardTypeNumberPad;
                    self.serviceDays = cell.field;
                    cell.field.userInteractionEnabled = YES;
                    break;
                case 2:
                    cell.field.placeholder = @"请选择服务地址";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    self.adressfield = cell.field;
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: {
            cell.textLabel.text = self.nannyTitle[indexPath.row];
            switch (indexPath.row) {
                case 0:
                    cell.field.placeholder = @"请填写年龄区间";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    self.agefield = cell.field;
                    break;
                case 1:
                    cell.field.placeholder = @"请选择您的家乡";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    self.homefield = cell.field;
                    break;
                case 2:
                    cell.field.placeholder = @"请选择月嫂的行业经验";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    self.expfield = cell.field;
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0: {
                DatePickerView *picker = [[DatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
                @weakify(self)
                picker.seletedDateBlock = ^(NSString *date) {
                    @strongify(self)
                    self.datefield.text = date;
                };
                [[UIApplication sharedApplication].keyWindow addSubview:picker];
            }
                break;
            case 2:{
                CommonChooseView *chooseView = [[CommonChooseView alloc] initWithFrame:[UIScreen mainScreen].bounds array:@[@"福州",@"厦门",@"宁德",@"莆田",@"泉州",@"漳州",@"龙岩",@"三明",@"南平"]];
                @weakify(self)
                chooseView.seletedDateBlock = ^(NSString *date) {
                    @strongify(self)
                    self.adressfield.text = date;
                };
                [[UIApplication sharedApplication].keyWindow addSubview:chooseView];
            }
                break;
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:{
                DataPickerView *data = [[DataPickerView alloc] initWithFrame:[UIScreen mainScreen].bounds firstArray:self.ageArray secondArray:self.ageArray];
                data.seletedDateBlock = ^(NSString *first, NSString *second) {
                    self.minAge = first;
                    self.maxAge = second;
                    self.agefield.text = [NSString stringWithFormat:@"%@-%@岁",first,second];
                };
                [[UIApplication sharedApplication].keyWindow addSubview:data];
            }
                break;
            case 1:{
                CommonChooseView *chooseView = [[CommonChooseView alloc] initWithFrame:[UIScreen mainScreen].bounds array:@[@"闽南",@"闽北",@"闽东",@"闽西",@"闽中",@"不限"]];
                @weakify(self)
                chooseView.seletedDateBlock = ^(NSString *date) {
                    @strongify(self)
                    self.homefield.text = date;
                };
                [[UIApplication sharedApplication].keyWindow addSubview:chooseView];
            }
                break;
            case 2:{
                CommonChooseView *chooseView = [[CommonChooseView alloc] initWithFrame:[UIScreen mainScreen].bounds array:@[@"1年",@"2年",@"3年",@"4年",@"5年",@"5年以上",@"不限"]];
                @weakify(self)
                chooseView.seletedDateBlock = ^(NSString *date) {
                    @strongify(self)
                    self.expfield.text = date;
                };
                [[UIApplication sharedApplication].keyWindow addSubview:chooseView];
            }
                break;
            default:
                break;
        }
    }
}

//- (void)getProvinceData {
//    if (self.viewModel.provinceArray.count>0) {
//        [self chooseProvince];
//    } else {
//        [self.viewModel.getProvinceCommand execute:nil];
//    }
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (NSArray *)myInfoTitle {
    if (!_myInfoTitle) {
        _myInfoTitle = [NSArray arrayWithObjects:@"预产期",@"服务天数",@"服务地址", nil];
    }
    return _myInfoTitle;
}

- (NSArray *)nannyTitle {
    if (!_nannyTitle) {
        _nannyTitle = [NSArray arrayWithObjects:@"年龄",@"家乡",@"经验", nil];
    }
    return _nannyTitle;
}

- (UIButton *)submit {
    if (!_submit) {
        _submit = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submit setTitle:@"发 布" forState:UIControlStateNormal];
        [_submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_submit.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _submit.backgroundColor = RGB(254, 212, 60);
        @weakify(self)
        [[_submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.datefield.text.length<1) {
                showMassage(@"请选择预产期");
                return ;
            }
            if (self.serviceDays.text.length<1) {
                showMassage(@"请填写服务的天数");
                return ;
            }
            
            if (self.adressfield.text.length<1) {
                showMassage(@"请选择服务地址");
                return ;
            }
            if (self.agefield.text.length<1) {
                showMassage(@"请选择月嫂的年龄区间");
                return ;
            }
            if (self.homefield.text.length<1) {
                showMassage(@"请选择月嫂的家乡");
                return ;
            }
            if (self.expfield.text.length<1) {
                showMassage(@"请选择月嫂经验要求");
                return ;
            }
            
            [self.viewModel.sendDemandCommand execute:@{@"dueDate":[self.datefield.text stringByAppendingString:@" 08:08:08"],@"moonExp":self.expfield.text,@"addr":self.adressfield.text,@"moonAgeMin":self.minAge,@"moonAgeMax":self.maxAge,@"moonAddr":self.homefield.text,@"serviceDay":self.serviceDays.text}];
        }];
    }
    return _submit;

}

-(SendDemandViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[SendDemandViewModel alloc] init];
    }
    return _viewModel;
}

- (NSArray *)ageArray {
    if (!_ageArray) {
        _ageArray = [NSArray arrayWithObjects:@"20",@"21",@"22",@"23",@"25",@"26",@"27",@"28",@"29",@"30",@"31",@"32",@"33",@"34",@"35",@"36",@"37",@"38",@"39",@"40",@"41",@"42",@"43",@"44",@"45",@"46",@"47",@"48",@"49",@"50",@"51",@"52",@"53",@"54",@"55",@"56",@"57",@"58",@"59",@"60", nil];
    }
    return _ageArray;
}

//- (NSArray *)priceArray {
//    if (!_priceArray) {
//        _priceArray = [NSArray arrayWithObjects:@"5000",@"6000",@"7000",@"8000",@"9000",@"10000",@"11000",@"12000",@"13000",@"14000",@"15000",@"16000",@"17000",@"18000",@"19000",@"20000",@"21000",@"22000",@"23000",@"24000",@"25000",@"26000",@"27000",@"28000",@"29000",@"30000", nil];
//    }
//    return _priceArray;
//}
@end
