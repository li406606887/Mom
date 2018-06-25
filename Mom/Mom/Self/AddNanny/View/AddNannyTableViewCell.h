//
//  AddNannyTableViewCell.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "InvitationNannyModel.h"

@interface AddNannyTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIcon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *mark;
@property (strong, nonatomic) InvitationNannyModel *model;
@end
