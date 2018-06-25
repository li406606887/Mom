//
//  SendDemandViewController.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ViewBaseController.h"

@interface SendDemandViewController : ViewBaseController
@property (copy, nonatomic) void (^refreshBlock) (void);
@end
