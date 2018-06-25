//
//  MyWelfareViewController.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ViewBaseController.h"

@interface MyWelfareViewController : ViewBaseController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@end
