//
//  DemandDetailsView.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "DemandDetailsViewModel.h"
#import "DemandDetailsHeadView.h"

@interface DemandDetailsView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) DemandDetailsViewModel *viewModel;

@property (strong, nonatomic) UITableView *table;

@property (strong, nonatomic) DemandDetailsHeadView *headView;

@property (strong, nonatomic) UIButton *allInvitation;
@end
