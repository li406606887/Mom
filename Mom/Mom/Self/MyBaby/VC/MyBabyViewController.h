//
//  MyBabyViewController.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ViewBaseController.h"
#import "BabyModel.h"

@interface MyBabyViewController : ViewBaseController
@property (assign, nonatomic) int state;//state 1000 可以点回调
@property (copy, nonatomic) void(^clickBlock) (BabyModel *model);
@end
