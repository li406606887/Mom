//
//  DemandDetailsTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DemandDetailsModel.h"

@interface DemandDetailsTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mark;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (strong, nonatomic) DemandDetailsModel *model;
@property (copy, nonatomic) void(^clickBlock)(DemandDetailsModel*model);
@end
