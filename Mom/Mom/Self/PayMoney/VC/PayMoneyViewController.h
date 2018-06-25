//
//  PayMoneyViewController.h
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ViewBaseController.h"
#import "NannyModel.h"
#import "PayMoneyViewModel.h"

@interface PayMoneyViewController : ViewBaseController
@property (strong, nonatomic) NannyModel *model;
@property (strong, nonatomic) PayMoneyViewModel *viewModel;
@end
