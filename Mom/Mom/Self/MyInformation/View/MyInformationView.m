
//
//  MyInformationView.m
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "MyInformationView.h"
#import "MyInformationViewTableViewCell.h"
#import "DemandTableViewCell.h"
#import "ChooseCityView.h"

@implementation MyInformationView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (MyInformationViewModel *)viewModel;
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

- (void)bindViewModel {
    self.viewModel.parentId = [UserInformation getInformation].userModel.provinceId;
    [self.viewModel.getProvinceCommand execute:nil];
    if ([UserInformation getInformation].userModel.provinceId.length>0) {
        [self.viewModel.getCityCommand execute:@{@"parentId":[UserInformation getInformation].userModel.provinceId}];

    }
}

# pragma mark table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return indexPath.row == 0 ? 80 : 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            MyInformationViewIconTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyInformationViewIconTableViewCell class])] forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.title.text = self.titleArray[indexPath.row];
            self.headIcon = cell.headIcon;
            return cell;
        }
            break;
        case 1:{
            MyInformationViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyInformationViewTableViewCell class])] forIndexPath:indexPath];
            cell.title.text = self.titleArray[indexPath.row];
            cell.details.text = [UserInformation getInformation].userModel.nickName;
            self.nameFiled = cell.details;
            return cell;
        }
            break;
        case 2:{
            DemandCityChooseCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([DemandCityChooseCell class])] forIndexPath:indexPath];
            cell.title.text = self.titleArray[indexPath.row];
            @weakify(self)
            _province = cell.address;
            _city = cell.all;
            cell.provinceBlock = ^{
                @strongify(self)
                [self getProvinceData];
            };
            if ([UserInformation getInformation].userModel.provinceId.length>0) {
                [cell.address setTitle:[UserInformation getInformation].userModel.provinceName forState:UIControlStateNormal];
            }
            cell.cityBlock = ^{
                @strongify(self)
                if (self.viewModel.parentId.length<1) {
                    showMassage(@"请先选择省份");
                    return ;
                }
                [self chooseCity];
            };
            if ([UserInformation getInformation].userModel.cityId.length>0) {
                [cell.all setTitle:[UserInformation getInformation].userModel.cityName forState:UIControlStateNormal];
            }
            return cell;
        }
            break;
        case 3:{
            MyInformationViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([MyInformationViewTableViewCell class])] forIndexPath:indexPath];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            cell.title.text = self.titleArray[indexPath.row];
            return cell;
        }
            break;
            
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        [self.viewModel.chooseHeadIconSubject sendNext:nil];
    }
}

- (void)getProvinceData {
    if (self.viewModel.provinceArray.count>0) {
        [self chooseProvince];
    } else {
        [self.viewModel.getProvinceCommand execute:nil];
    }
}

- (void)chooseProvince {
    @weakify(self)
    ChooseCityView *chooseView = [[ChooseCityView alloc] initWithArray:self.viewModel.provinceArray];
    chooseView.headTilte.text = @"选择省份";
    chooseView.cellClickBlock = ^(ProvinceModel *model) {
        @strongify(self)
        [self.province setTitle:model.name forState:UIControlStateNormal];
        [self.city setTitle:@"全部" forState:UIControlStateNormal];
        [self.viewModel.getCityCommand execute:@{@"parentId":model.ID}];
        self.viewModel.parentId = model.ID;
        self.viewModel.cityId = @"";
    };
    [chooseView show];
}

- (void)chooseCity {
    @weakify(self)
    ChooseCityView *chooseView = [[ChooseCityView alloc] initWithArray:self.viewModel.cityArray];
    chooseView.headTilte.text = @"选择城市";
    chooseView.cellClickBlock = ^(ProvinceModel *model) {
        @strongify(self)
        self.viewModel.cityId = model.ID;
        [self.city setTitle:model.name forState:UIControlStateNormal];
    };
    [chooseView show];
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
        [_table registerClass:[MyInformationViewTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyInformationViewTableViewCell class])]];
        [_table registerClass:[MyInformationViewIconTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([MyInformationViewIconTableViewCell class])]];
        [_table registerClass:[DemandCityChooseCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([DemandCityChooseCell class])]];
    }
    return _table;
}


-(NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"头像",@"昵称",@"城市",nil];//,@"我的收货地址"
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
            NSMutableDictionary *param = [NSMutableDictionary dictionary];
            if (self.headUrl.length>10) {
                [param setObject:self.headUrl forKey:@"headUrl"];
            }
            if (self.nameFiled.text.length>0&&![self.nameFiled.text isEqualToString:[UserInformation getInformation].userModel.nickName]) {
                [param setObject:self.nameFiled.text forKey:@"nickName"];
            }
            if (self.viewModel.cityId.length>0) {
                [param setObject:self.viewModel.parentId forKey:@"provinceId"];
                [param setObject:self.viewModel.cityId forKey:@"cityId"];
            }
            if (param.count<1) {
                showMassage(@"请核对您要修改的内容");
                return ;
            }
            [self.viewModel.saveInfoCommand execute:param];
        }];
    }
    return _sureBtn;
}
@end
