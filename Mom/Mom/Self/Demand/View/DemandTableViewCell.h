//
//  DemandTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "DemandModel.h"

@interface DemandTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *demandTitle;
@property (copy, nonatomic) DemandModel *model;
@property (weak, nonatomic) IBOutlet UILabel *markInfo;
@property (weak, nonatomic) IBOutlet UILabel *browseDetails;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@end

@interface DemandCityChooseCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIButton *address;
@property (strong, nonatomic) UIButton *all;
@property (copy, nonatomic) void (^cityBlock)(void);
@property (copy, nonatomic) void (^provinceBlock)(void);
@end
