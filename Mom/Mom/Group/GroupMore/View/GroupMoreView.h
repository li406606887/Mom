//
//  GroupMoreView.h
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "BaseView.h"
#import "GroupMoreViewModel.h"
#import "GroupDetailsTableViewCell.h"

@interface GroupMoreView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) GroupMoreViewModel *viewModel;

@property (strong, nonatomic) UITableView *table;
@end
