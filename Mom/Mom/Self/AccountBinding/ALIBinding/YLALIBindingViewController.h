//
//  YLALIBindingViewController.h
//  Mom
//
//  Created by wgz on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ViewBaseController.h"

@interface YLALIBindingViewController : ViewBaseController
@property(nonatomic,copy) void (^backBlock)(void);
@end
