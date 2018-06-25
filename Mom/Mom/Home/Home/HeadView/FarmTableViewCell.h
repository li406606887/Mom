//
//  FarmTableViewCell.h
//  FamilyFarm
//
//  Created by user on 2017/10/19.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "FarmModel.h"

@interface FarmTableViewCell : BaseTableViewCell
@property (copy, nonatomic) FarmModel *model;
@property (copy, nonatomic) void (^btnClickBlock) (FarmModel *model);
@end
