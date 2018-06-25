//
//  FarmView.h
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"

@interface FarmView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) UITableView *table;
@end
