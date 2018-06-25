//
//  YiGeSheetView.h
//  Mom
//
//  Created by wgz on 2018/6/7.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BankSheetModel.h"

@interface YiGeSheetView : UIView

@property (nonatomic, strong) UIView  * backImageView;

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,assign) NSInteger selectIndex;

@property(nonatomic,copy) void (^goonBlock)(void);
@property (nonatomic,copy) void (^closeBlock)(void);
@property (nonatomic,copy) void (^selcetBlock)(BankSheetModel *  model);

-(id)initWithSortDataArray:(NSArray *)dataArray;

- (void)show;

@end
