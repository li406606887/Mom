//
//  FarmView.m
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "FarmView.h"
#import "FarmViewModel.h"
#import "FarmHeadView.h"
#import "FarmTableViewCell.h"
#import "SegmentedControlView.h"
#import "CouponsTableViewCell.h"

@interface FarmView()
@property(nonatomic,strong) FarmHeadView *headView;
@property(nonatomic,strong) FarmViewModel *viewModel;
@end

@implementation FarmView
#pragma mark 初始化绑定viewModel
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (FarmViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.table];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)bindViewModel {
    [self.viewModel.refreshProblemSubject subscribeNext:^(id  _Nullable x) {
        [self.table reloadData];
    }];
}

#pragma mark tableView 代理事件
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    title.layer.masksToBounds = YES;
    title.layer.cornerRadius = 5;
    title.text = @"     活动推荐";
    title.backgroundColor = RGB(255, 218, 68);
    [sectionView addSubview:title];
    UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
    [more setFrame:CGRectMake(SCREEN_WIDTH-70, 0, 60, 40)];
    [more setTitle:@"更多 >" forState:UIControlStateNormal];
    [more setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [more.titleLabel setFont:[UIFont systemFontOfSize:17]];
    @weakify(self)
    [[more rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        [self.viewModel.moreTableSubject sendNext:nil];
    }];
    [sectionView addSubview:more];
    return sectionView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.problemArray.count>0) {
        return 2;
    }else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.viewModel.problemArray.count>0) {
        if (indexPath.row == 0) {
            return 100;
        }else {
            if (self.viewModel.couponsArray.count>0) {
                CouponsModel *model = self.viewModel.couponsArray[0];
                if (![NSDate isTodayWithDate:model.endTime]) {
                    return 110;
                } else {
                    return 160;
                }
            }else {
                return 221;
            }
        }
    }else {
        return 221;
    }
   
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.viewModel.problemArray.count>0) {
        if (indexPath.row == 0 ) {
            FarmTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([FarmTableViewCell class])] forIndexPath:indexPath];
            cell.model = self.viewModel.problemArray[indexPath.row];
            @weakify(self)
            cell.btnClickBlock = ^(FarmModel *model) {
                @strongify(self)
                [self.viewModel.joinActivityCommand execute:@{@"activityId":model.ID}];
            };
            return cell;
        } else {
            if (self.viewModel.couponsArray.count>0) {
                CouponsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([CouponsTableViewCell class])] forIndexPath:indexPath];
                CouponsModel *model = self.viewModel.couponsArray[0];
                cell.model = model;
                return cell;
            }else {
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dalibaoCell" forIndexPath:indexPath];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
                title.text = @"    我的大礼包";
                title.backgroundColor = RGB(255, 212, 60);
                title.font = [UIFont systemFontOfSize:16];
                [cell addSubview:title];
                UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 170)];
                content.text =  @"非常6+1:拍三次，每次提供两套衣服，四个造型，四个场景三张底片赠送一本6*6的爱婴册\n\n线下公开课:瑜伽课、拉玛泽、艺术课(每人总共4次),孕期营养、产前母乳指导\n\n产康:产后身体机能检测1次、满月发汗1次\n\n获取条件:妈妈端与月嫂端绑定成功后,方可绑定大礼包";
                content.font = [UIFont systemFontOfSize:13];
                content.numberOfLines = 0;
                [cell addSubview:content];
                return cell;
            }
        }
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dalibaoCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        title.text = @"    我的大礼包";
        title.backgroundColor = RGB(255, 212, 60);
        title.font = [UIFont systemFontOfSize:16];
        [cell addSubview:title];
        UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(15, 40, SCREEN_WIDTH-30, 170)];
        content.text =  @"非常6+1:拍三次，每次提供两套衣服，四个造型，四个场景三张底片赠送一本6*6的爱婴册\n\n线下公开课:瑜伽课、拉玛泽、艺术课(每人总共4次),孕期营养、产前母乳指导\n\n产康:产后身体机能检测1次、满月发汗1次\n\n获取条件:妈妈端与月嫂端绑定成功后,方可绑定大礼包";
        content.font = [UIFont systemFontOfSize:13];
        content.numberOfLines = 0;
        [cell addSubview:content];
        return cell;

    }
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.viewModel.problemArray.count>0) {
        if (indexPath.row==0) {
            [self.viewModel.clickTableSubject sendNext:self.viewModel.problemArray[indexPath.row]];
        }else {
            NSLog(@"123");
        }
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
        _table.backgroundColor = RGB(242, 242, 242);
//        _table.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
//        _table.separatorColor = RGB(255, 218, 68);
        _table.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_table registerClass:[FarmTableViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([FarmTableViewCell class])]];
        _table.tableHeaderView = self.headView;
        [_table registerNib:[UINib nibWithNibName:@"CouponsTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([CouponsTableViewCell class])]];
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"dalibaoCell"];
    }
    return _table;
}
-(FarmHeadView *)headView {
    if (!_headView) {
        _headView = [[FarmHeadView alloc] initWithViewModel:self.viewModel];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 260);
    }
    return _headView;
}
@end
