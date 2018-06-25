//
//  MyWelfareTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "MyWelfareModel.h"

@interface MyWelfareTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (strong, nonatomic) MyWelfareModel *model;
@end
