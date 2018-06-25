//
//  SearchNannyTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/22.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "InvitationNannyModel.h"

@interface SearchNannyTableViewCell : BaseTableViewCell
@property (copy, nonatomic) InvitationNannyModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mark;
@property (weak, nonatomic) IBOutlet UILabel *status;
@end
