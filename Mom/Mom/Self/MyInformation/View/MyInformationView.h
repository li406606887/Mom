//
//  MyInformationView.h
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "MyInformationViewModel.h"

@interface MyInformationView : BaseView<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) MyInformationViewModel *viewModel;
@property (nonatomic,strong) UITableView *table;
@property (nonatomic,strong) NSArray *titleArray;
@property (strong, nonatomic) UIButton *sureBtn;
@property (copy, nonatomic) UIButton *province;
@property (copy, nonatomic) UIButton *city;
@property (strong, nonatomic) UITextField *nameFiled;
@property (copy, nonatomic) NSString *headUrl;
@property (strong, nonatomic) UIImageView *headIcon;
@end
