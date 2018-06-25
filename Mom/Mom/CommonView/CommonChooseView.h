//
//  CommonChooseView.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonChooseView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSArray *titleArray;

@property (strong, nonatomic) UIView *backgroundView;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) void (^seletedDateBlock)(NSString *date);

- (instancetype)initWithFrame:(CGRect)frame array:(NSArray *)array;
@end
