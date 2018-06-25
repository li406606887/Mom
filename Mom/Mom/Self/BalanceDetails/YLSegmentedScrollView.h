//
//  YLSegmentedScrollView.h
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"

@interface YLSegmentedScrollView : UIView
@property(nonatomic,copy)void (^itemClick)(int index);
-(instancetype)initWithFrame:(CGRect)frame item:(NSArray *)items;
@property(nonatomic,assign) int selectedIndex;
@property(nonatomic,strong) UIColor *defultTitleColor;//默认标题颜色
@property(nonatomic,strong) UIColor *selectedTitleColor;//选中标题颜色
@property(nonatomic,strong) UIColor *lineColor;//选中标题颜色
@property(nonatomic,assign) CGFloat font;//字号大小
@property(nonatomic,assign) int  oldIndex;
@property(nonatomic,strong) NSArray *itemArray;
-(void)show;
@end

