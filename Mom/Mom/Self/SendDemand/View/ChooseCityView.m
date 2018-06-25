//
//  ChooseCityView.m
//  FamilyFarm
//
//  Created by together on 2018/4/25.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ChooseCityView.h"

@implementation ChooseCityView
- (instancetype)initWithArray:(NSArray *)array {
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        _array = array;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:self.table];
        [self addSubview:self.headView];
    }
    return self;
}

- (void)layoutSubviews {
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 240));
    }];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.table.mas_top);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    [self.headTilte mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headView).with.offset(15);
        make.centerY.equalTo(self.headView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 40));
    }];
    [super layoutSubviews];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
    [super touchesEnded:touches withEvent:event];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 1;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"chooseCityCell" forIndexPath:indexPath];
    ProvinceModel *model = self.array[indexPath.row];
    cell.textLabel.text = model.name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cellClickBlock) {
        self.cellClickBlock(self.array[indexPath.row]);
    }
    [self removeFromSuperview];
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.sectionHeaderHeight = 1;
        if (@available(iOS 11.0, *)) {
            _table.estimatedRowHeight = 0;
            _table.estimatedSectionFooterHeight = 0;
            _table.estimatedSectionHeaderHeight = 0;
            _table.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"chooseCityCell"];
    }
    return _table;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UIView *)headView {
    if (!_headView) {
        _headView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [_headView setBackgroundColor:[UIColor whiteColor]];
        [_headView addSubview:self.headTilte];
    }
    return _headView;
}

- (UILabel *)headTilte {
    if (!_headTilte) {
        _headTilte = [[UILabel alloc] init];
        _headTilte = [[UILabel alloc] init];
        [_headTilte setFont:[UIFont systemFontOfSize:14]];
    }
    return _headTilte;
}
@end
