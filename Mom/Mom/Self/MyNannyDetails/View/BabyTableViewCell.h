//
//  BabyTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BabyModel.h"

@interface BabyTableViewCell : BaseTableViewCell
@property (copy, nonatomic) BabyModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *birthDate;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
