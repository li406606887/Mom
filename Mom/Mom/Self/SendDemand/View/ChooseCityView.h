//
//  ChooseCityView.h
//  FamilyFarm
//
//  Created by together on 2018/4/25.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProvinceModel.h"

@interface ChooseCityView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (copy, nonatomic) UITableView *table;

@property (strong, nonatomic) UILabel *headTilte;

@property (strong, nonatomic) UIView *headView;

@property (copy, nonatomic) NSArray *array;

@property (copy, nonatomic) void (^cellClickBlock) (ProvinceModel * model);

- (instancetype)initWithArray:(NSArray *)array;

- (void)show;
@end
