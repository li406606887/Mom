//
//  JaundiceRecordViewController.h
//  Mom
//
//  Created by together on 2018/5/30.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "ViewBaseController.h"
#import "BabyModel.h"

@interface JaundiceRecordViewController : ViewBaseController<UITableViewDelegate,UITableViewDataSource>
@property (copy, nonatomic) BabyModel *model;
@end