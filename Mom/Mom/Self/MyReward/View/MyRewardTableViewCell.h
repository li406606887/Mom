//
//  MyRewardTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/28.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyRewardModel.h"

@interface MyRewardTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (copy, nonatomic) MyRewardModel *model;
@end
