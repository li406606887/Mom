//
//  AddNannyViewController.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ViewBaseController.h"
#import "InvitationNannyModel.h"

@interface AddNannyViewController : ViewBaseController
@property (strong, nonatomic) InvitationNannyModel *model;
@property (assign, nonatomic) int state;//1返回跟控制器
@end
