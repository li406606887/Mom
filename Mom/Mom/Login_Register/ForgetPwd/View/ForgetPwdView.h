//
//  ForgetPwdView.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "ForgetPwdViewModel.h"

@interface ForgetPwdView : BaseView
@property (copy, nonatomic) ForgetPwdViewModel *viewModel;

@property (strong, nonatomic) UITextField *phoneField;

@property (strong, nonatomic) UITextField *newPwdField;

@property (strong, nonatomic) UITextField *verificationField;

@property (strong, nonatomic) UIButton *isVisible;

@property (strong, nonatomic) UILabel *verificationBtn;

@property (strong, nonatomic) UIButton *sureBtn;

@property (strong, nonatomic) UIButton *agreement;

@property (strong, nonatomic) UIButton *question;

@property (copy, nonatomic) NSTimer *timer;

@property (assign, nonatomic) int secondsCount;
@end
