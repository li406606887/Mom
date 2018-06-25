//
//  PregnancyView.h
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "PregnancyViewModel.h"

@interface PregnancyView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) PregnancyViewModel *viewModel;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) NSArray *detailsArray;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) UIButton *start;
@end
