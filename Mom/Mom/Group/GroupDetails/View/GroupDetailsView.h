//
//  GroupDetailsView.h
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "BaseView.h"
#import "GroupDetailsViewModel.h"
#import "GroupDetailsTableViewCell.h"
#import "GroupDetailsToolView.h"
#import "GroupDetailsHeadView.h"

@interface GroupDetailsView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) GroupDetailsViewModel *viewModel;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) GroupDetailsHeadView *headView;

@property (strong, nonatomic) GroupDetailsToolView *toolView;
@end
