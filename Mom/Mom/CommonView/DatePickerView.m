//
//  DatePickerView.m
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "DatePickerView.h"

@implementation DatePickerView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:self.backgroundView];
    [self.backgroundView addSubview:self.pickerView];
    [self.backgroundView addSubview:self.selectedBtn];
    [self setNeedsUpdateConstraints];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}

- (void)updateConstraints {
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 320));
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backgroundView);
        make.top.equalTo(self.backgroundView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 250));
    }];
    
    [self.selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickerView.mas_bottom);
        make.centerX.equalTo(self.backgroundView);
        make.width.offset(SCREEN_WIDTH);
        make.bottom.equalTo(self.backgroundView.mas_bottom);
    }];
    [super updateConstraints];
}

- (UIDatePicker *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIDatePicker alloc] init];
        _pickerView.datePickerMode = UIDatePickerModeDate;
    }
    return _pickerView;
}

- (UIButton *)selectedBtn {
    if (!_selectedBtn) {
        _selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectedBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_selectedBtn setTitleColor:RGB(90, 90, 90) forState:UIControlStateNormal];
        [_selectedBtn setBackgroundColor:RGB(254, 211, 54)];
        @weakify(self)
        [[_selectedBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"YYYY-MM-dd"];
            NSString *currentTimeString = [formatter stringFromDate:self.pickerView.date];
            if (self.seletedDateBlock) {
                self.seletedDateBlock(currentTimeString);
            }
            [self removeFromSuperview];
        }];
    }
    return _selectedBtn;
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
