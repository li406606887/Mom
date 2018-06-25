//
//  CommonChooseView.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "CommonChooseView.h"

@implementation CommonChooseView
- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array  {
    if (self = [super initWithFrame:frame]) {
        self.titleArray = [array mutableCopy];
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.table];
    [self setNeedsUpdateConstraints];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (void)updateConstraints {
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 320));
    }];
    [self.table mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 320));
    }];
    
    [super updateConstraints];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommonChooseCell" forIndexPath:indexPath];
    cell.textLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 50);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.text = self.titleArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"请选择";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.seletedDateBlock) {
        self.seletedDateBlock(self.titleArray[indexPath.row]);
    }
    [self removeFromSuperview];
}

- (UITableView *)table {
    if (!_table) {
        _table = [[UITableView alloc] initWithFrame:self.frame style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        [_table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CommonChooseCell"];
    }
    return _table;
}

-(UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.layer.masksToBounds = YES;
        _backgroundView.layer.cornerRadius = 4;
    }
    return _backgroundView;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
