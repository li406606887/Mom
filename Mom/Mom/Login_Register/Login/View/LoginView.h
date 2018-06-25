//
//  LoginView.h
//  FamilyFarm
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "LoginViewModel.h"


@interface LoginView : BaseView
@property (strong, nonatomic) LoginViewModel *viewModel;
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UITextField *phone;
@property (strong, nonatomic) UITextField *pwd;
@property (strong, nonatomic) UILabel *validationLabel;
@property (strong, nonatomic) UIButton *login;
@property (strong, nonatomic) UIButton *agreement;
@property (strong, nonatomic) UIButton *pwdBtn;
@property (strong, nonatomic) UILabel *otherLoginWay;
@property (strong, nonatomic) UIButton *wxBtn;
@property (strong, nonatomic) UIButton *alipayBtn;
@end
