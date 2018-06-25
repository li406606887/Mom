//
//  BindPhoneView.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "BindPhoneViewModel.h"

@interface BindPhoneView : BaseView
@property (strong, nonatomic) BindPhoneViewModel *viewModel;
@property (strong, nonatomic) UITextField *phone;
@property (strong, nonatomic) UITextField *validationField;
@property (strong, nonatomic) UILabel *validationBtn;
@property (strong, nonatomic) UIButton *login;
@property (copy, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int secondsCount;    
@end
