//
//  YLAccountBindingMainView.h
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "UserDataModel.h"

@interface YLAccountBindingMainView : BaseView
@property (nonatomic,strong) UserDataModel *userModel;

@property (nonatomic,strong) UITableView *tableView;
@end
