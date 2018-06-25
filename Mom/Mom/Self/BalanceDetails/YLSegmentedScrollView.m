//
//  YLYLSegmentedScrollView.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLSegmentedScrollView.h"

@interface YLSegmentedScrollView ()<UIScrollViewDelegate>
@property(nonatomic,strong) UIScrollView *scroll;
@property(nonatomic,strong) UIView *line;
@property(nonatomic,strong) NSMutableArray *btnArray;
@property(nonatomic,assign) CGFloat spacing;
@end

@implementation YLSegmentedScrollView

-(instancetype)initWithFrame:(CGRect)frame item:(NSArray *)items {
    if (self = [super initWithFrame:frame]) {
        self.itemArray = items;
        [self addSubview:self.scroll];
    }
    return self;
}

-(void)scrollItemClick:(UIButton *)button{
    int index = (int)button.tag;
    if (index == self.oldIndex) return;
    
    UIButton *oldbtn = self.btnArray[self.oldIndex];
    oldbtn.selected = NO;
    button.selected = YES;
    
    UIButton*newButton = self.btnArray[index];;
    newButton.selected = YES;
    
    CGSize size = [NSAttributedString getTextSizeWithText:newButton.titleLabel.text withMaxSize:CGSizeMake(MAXFLOAT, 15) withLineSpacing:0];
    [UIView animateWithDuration:0.3 animations:^{
        [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self.scroll).with.offset(button.centerX-25);
            make.left.equalTo(self.scroll).with.offset(newButton.centerX-(size.width/2));
            make.size.mas_offset(CGSizeMake(size.width, 2));
        }];
        [self.line.superview layoutIfNeeded];//强制绘制
    }];
    
    self.oldIndex = index;
    self.oldIndex = (int)button.tag;
    if (self.itemClick) self.itemClick(self.oldIndex);
}

-(void)setSelectedIndex:(int)selectedIndex {
    UIButton*oldButton = self.btnArray[self.oldIndex];
    oldButton.selected = NO;
    UIButton*newButton = self.btnArray[selectedIndex];;
    newButton.selected = YES;
    
    CGSize size = [NSAttributedString getTextSizeWithText:newButton.titleLabel.text withMaxSize:CGSizeMake(MAXFLOAT, 15) withLineSpacing:0];
    [UIView animateWithDuration:0.3 animations:^{
        [self.line mas_updateConstraints:^(MASConstraintMaker *make) {
            //            make.left.equalTo(self.scroll).with.offset(newButton.centerX-25);//固定宽度 50
            make.left.equalTo(self.scroll).with.offset(newButton.centerX-(size.width/2));
            make.size.mas_offset(CGSizeMake(size.width, 2));
        }];
        [self.line.superview layoutIfNeeded];//强制绘制
    }];
    self.oldIndex = selectedIndex;
    
}

-(void)setSelectedTitleColor:(UIColor *)selectedTitleColor {
    _selectedTitleColor = selectedTitleColor;
}

-(void)setDefultTitleColor:(UIColor *)defultTitleColor {
    _defultTitleColor = defultTitleColor;
}

-(void)setLineColor:(UIColor *)lineColor {
    _lineColor = lineColor;
}

-(void)show {
    
    [self.scroll.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.btnArray removeAllObjects];
    [self.scroll addSubview:self.line];
    int i = 0;
    for (NSString *title in self.itemArray) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTag:i];
        [button setTitle:title forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button setTitleColor:self.defultTitleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        [button addTarget:self action:@selector(scrollItemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.btnArray addObject:button];
        [self.scroll addSubview:button];
        button.selected = i == 0 ? YES : NO;
        [button setFrame:CGRectMake(self.spacing*i, 0, self.spacing, 30)];
        
        if (i==0) {
            CGSize size = [NSAttributedString getTextSizeWithText:title withMaxSize:CGSizeMake(MAXFLOAT, 15) withLineSpacing:0];
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(button.mas_bottom);
                //                make.left.equalTo(self.scroll).with.offset(button.centerX-25);
                //                make.size.mas_offset(CGSizeMake(50, 2));
                make.left.equalTo(self.scroll).with.offset(button.centerX-(size.width/2));
                make.size.mas_offset(CGSizeMake(size.width, 2));
                
            }];
        }
        i++;
    }
    NSLog(@"segment遍历完--->%d",i);
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = self.lineColor;
    }
    return _line;
}

-(UIScrollView *)scroll {
    if (!_scroll) {
        _scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scroll.delegate = self;
        _scroll.showsHorizontalScrollIndicator = NO;
    }
    return _scroll;
}

-(NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [[NSMutableArray alloc] init];
    }
    return _btnArray;
}

-(int)oldIndex {
    if (!_oldIndex) {
        _oldIndex = 0;
    }
    return _oldIndex;
}

-(void)setItemArray:(NSArray *)itemArray {
    _itemArray = itemArray;
    self.spacing = 0.0f;
    for (NSString *title in itemArray) {
        CGSize size = [NSAttributedString getTextSizeWithText:title withMaxSize:CGSizeMake(MAXFLOAT, 15) withLineSpacing:0];
        if (self.spacing < size.width +10) {
            self.spacing = size.width +10;
            NSLog(@"segment间隔->%f",self.spacing);
        }
    }
    if (self.spacing*itemArray.count < (SCREEN_WIDTH-20)) {
        self.spacing = (SCREEN_WIDTH - 20)/itemArray.count;
    }
    int count = (int)itemArray.count;
    if (count*self.spacing > SCREEN_WIDTH-20) {
        self.scroll.contentSize = CGSizeMake(self.spacing *count, 0.5f);
    }else{
        self.spacing = SCREEN_WIDTH/count;
        self.scroll.contentSize = CGSizeMake(self.frame.size.width, 0.5f);
    }
    
    NSLog(@"segment->%f",self.spacing);
}
@end
