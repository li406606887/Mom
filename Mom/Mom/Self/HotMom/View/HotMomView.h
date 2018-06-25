//
//  HotMomView.h
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "HotMomViewModel.h"

@interface HotMomView : BaseView<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) HotMomViewModel *viewModel;
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) NSArray *detailsArray;
@property (strong, nonatomic) NSArray *titleArray;
@property (weak, nonatomic) UITextField *nameField;
@property (weak, nonatomic) UITextField *dateField;

@property (strong, nonatomic) UIButton *sureBtn;
@end
