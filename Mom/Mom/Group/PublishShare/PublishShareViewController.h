//
//  PublishShareViewController.h
//  HNProject
//
//  Created by user on 2017/7/19.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "ViewBaseController.h"

@interface PublishShareViewController : ViewBaseController
@property (copy, nonatomic) void(^refreshBlock) (void);
@end
