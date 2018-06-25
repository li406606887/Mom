//
//  JaundiceTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/30.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "JaundiceObserModel.h"

@interface JaundiceTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *nannyName;
@property (weak, nonatomic) IBOutlet UILabel *babyName;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (copy, nonatomic) JaundiceObserModel *model;
@end
