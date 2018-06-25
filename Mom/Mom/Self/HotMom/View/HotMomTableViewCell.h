//
//  HotMomTableViewCell.h
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseTableViewCell.h"

@interface HotMomTableViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UITextField *details;
@end


@interface HotMomTableBtnViewCell : BaseTableViewCell
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIButton *girl;
@property (strong, nonatomic) UIButton *boy;
@end
