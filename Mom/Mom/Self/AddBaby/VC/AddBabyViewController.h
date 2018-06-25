//
//  AddBabyViewController.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ViewBaseController.h"
#import "BabyModel.h"

@interface AddBabyViewController : ViewBaseController
@property (copy, nonatomic) BabyModel *model;
@property (assign, nonatomic) int state;
@end
