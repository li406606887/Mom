//
//  MyInformationViewTableViewCell.h
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface MyInformationViewTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UITextField *details;
@end

@interface MyInformationViewIconTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIImageView *headIcon;
@property (strong, nonatomic) UIImageView *backHeadIcon;
@end
