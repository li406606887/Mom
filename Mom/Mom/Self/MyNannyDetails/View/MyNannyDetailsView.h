//
//  MyNannyDetailsView.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "MyBabyTableViewCell.h"
#import "MyNannyDetailsViewModel.h"
#import "MyNannyDetailsHeadView.h"

@interface MyNannyDetailsView : BaseView<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) MyNannyDetailsViewModel *viewModel;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) NSArray *sectionArray;
@property (strong, nonatomic) MyNannyDetailsHeadView *headView;
@end
