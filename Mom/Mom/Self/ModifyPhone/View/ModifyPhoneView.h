//
//  ModifyPhoneView.h
//  Mom
//
//  Created by together on 2018/6/8.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "ModifyPhoneViewModel.h"

@interface ModifyPhoneView : BaseView
@property (strong, nonatomic) ModifyPhoneViewModel *viewModel;
@property (strong, nonatomic) UITextField *phone;
@property (strong, nonatomic) UITextField *validationField;
@property (strong, nonatomic) UILabel *validationBtn;
@property (strong, nonatomic) UIButton *login;
@property (copy, nonatomic) NSTimer *timer;
@property (assign, nonatomic) int secondsCount;
@end
