//
//  TabBarBaseController.h
//  RDFuturesApp
//
//  Created by user on 17/2/28.
//  Copyright © 2017年 FuturesApp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarBaseController : UITabBarController<UITabBarDelegate,UITabBarControllerDelegate>
@property (copy, nonatomic) void (^outLoginBlock) (void);
@end
