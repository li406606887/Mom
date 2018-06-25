//
//  PickerView.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "DataPickerView.h"

@implementation DataPickerView
- (instancetype)initWithFrame:(CGRect)frame firstArray:(NSArray *)firstArray secondArray:(NSArray*)secondArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.firstArray = firstArray;
        self.sectionArray = secondArray;
        self.firstValue = firstArray[0];
        self.secondValue = secondArray[0];
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

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

//这个方法是用来设置每个选择器各自有多少行数据

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) {
        return [self.firstArray count];
    }
    return [self.sectionArray count];
}

//这个方法是向每个选择器中添加数据（动态加载的）
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        return  [self.firstArray objectAtIndex:row];
    }
    return [self.sectionArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (component==0) {
        return SCREEN_WIDTH*0.5;
    }else {
        return SCREEN_WIDTH*0.5;
    }
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component ==0) {
        self.firstValue = self.firstArray[row];
    }else {
        self.secondValue = self.sectionArray[row];
    }
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
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
            if ([self.secondValue intValue]<[self.firstValue intValue]) {
                showMassage(@"请核对您选择的区间是否正确");
            }else{
                if (self.seletedDateBlock) {
                    self.seletedDateBlock(self.firstValue,self.secondValue);
                }
                [self removeFromSuperview];
            }
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

@end
