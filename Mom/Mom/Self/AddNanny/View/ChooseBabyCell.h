//
//  ChooseBabyCell.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "BabyModel.h"

@interface ChooseBabyCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *babyIcon;
@property (weak, nonatomic) IBOutlet UILabel *babyName;
@property (weak, nonatomic) IBOutlet UILabel *birthDate;
@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (strong, nonatomic) BabyModel *model;
@property (copy, nonatomic) void(^cellClickBlock) (BabyModel *model);
@end
