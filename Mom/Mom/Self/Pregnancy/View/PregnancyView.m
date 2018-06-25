//
//  PregnancyView.m
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "PregnancyView.h"
#import "PregnancyTableViewCell.h"

@implementation PregnancyView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (PregnancyViewModel *)viewModel;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 30;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        title.text = @"      如果您不清楚预产期，请告诉\"月靓妈妈\"您最近一次经期。";
        title.font = [UIFont systemFontOfSize:10];
        title.textColor = RGB(90, 90, 90);
        return title;
    }else {
        return nil;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PregnancyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([PregnancyTableViewCell class])] forIndexPath:indexPath];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    cell.title.text = self.titleArray[indexPath.section];
    cell.details.text = self.detailsArray[indexPath.section];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    switch (<#expression#>) {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
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
        _table.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        [footView addSubview:self.start];
        _table.tableFooterView = footView;
        [_table registerClass:[PregnancyTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([PregnancyTableViewCell class])]];
    }
    return _table;
}

-(NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"设置预产期",@"计算预产期",nil];
    }
    return _titleArray;
}

- (NSArray *)detailsArray {
    if (!_detailsArray) {
        _detailsArray = [NSArray arrayWithObjects:@"您的预产期是哪天?",@"最近一次经期开始日",nil];
    }
    return _detailsArray;
}

- (UIButton *)start {
    if (!_start) {
        _start = [UIButton buttonWithType:UIButtonTypeCustom];
        [_start  setBackgroundColor:RGB(254, 212, 54)];
        [_start setTitle:@"开始体验" forState:UIControlStateNormal];
        [_start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_start.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _start.frame = CGRectMake(30, 0, SCREEN_WIDTH-60, 44);
        _start.layer.masksToBounds = YES;
        _start.layer.cornerRadius = 4;
        @weakify(self)
        [[_start rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.saveDateSubject sendNext:nil];
        }];
    }
    return _start;
}
@end
