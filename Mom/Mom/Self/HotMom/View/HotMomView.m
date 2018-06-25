//
//  HotMomView.m
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "HotMomView.h"
#import "HotMomTableViewCell.h"
#import "DatePickerView.h"

@implementation HotMomView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (HotMomViewModel *)viewModel;
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            HotMomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([HotMomTableViewCell class])] forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.title.text = self.titleArray[indexPath.row];
            cell.details.text = self.detailsArray[indexPath.row];
            self.nameField = cell.details;
            return cell;
        }
            break;
        case 1: {
            HotMomTableBtnViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([HotMomTableBtnViewCell class])] forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.title.text = self.titleArray[indexPath.row];
            return cell;
        }
            break;
        case 2: {
            HotMomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([HotMomTableViewCell class])] forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.title.text = self.titleArray[indexPath.row];
            cell.details.placeholder = [NSDate getNowDateWithFormatter:@"YYYY-MM-dd"];
            cell.details.userInteractionEnabled = NO;
            self.dateField = cell.details;
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 2: {
            DatePickerView *dateView = [[DatePickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
            @weakify(self)
            dateView.seletedDateBlock = ^(NSString *date) {
                @strongify(self)
                self.dateField.text = date;
            };
            [self addSubview:dateView];
        }
            break;
        default:
            break;
    }
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
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [footView addSubview:self.sureBtn];
        _table.tableFooterView = footView;
        _table.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        [_table registerClass:[HotMomTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HotMomTableViewCell class])]];
        [_table registerClass:[HotMomTableBtnViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([HotMomTableBtnViewCell class])]];
        
    }
    return _table;
}

-(NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"宝宝小名",@"宝宝性别",@"宝宝出生日期",nil];
    }
    return _titleArray;
}

-(UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn  setBackgroundColor:RGB(254, 212, 54)];
        [_sureBtn setTitle:@"确 定" forState:UIControlStateNormal];
        [_sureBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _sureBtn.frame = CGRectMake(30, 0, SCREEN_WIDTH-60, 44);
        _sureBtn.layer.masksToBounds = YES;
        _sureBtn.layer.cornerRadius = 4;
        @weakify(self)
        [[_sureBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
//            [self.viewModel ];
        }];
    }
    return _sureBtn;
}
@end
