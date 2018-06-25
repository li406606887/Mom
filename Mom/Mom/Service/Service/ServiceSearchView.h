//
//  ServiceSearchView.h
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "ServiceViewModel.h"

@interface ServiceSearchView : BaseView
@property(nonatomic,strong) UIView *searchView;
@property(nonatomic,strong) UITextField *searchTextField;
@property(nonatomic,strong) UIButton *searchBtn;
@property(nonatomic,copy) NSString* title;
@property(nonatomic,strong) ServiceViewModel *viewModel;
@end
