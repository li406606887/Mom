//
//  PassWordLoginView.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "PWDLoginViewModel.h"

@interface PassWordLoginView : BaseView
@property (strong, nonatomic) PWDLoginViewModel *viewModel;
@property (strong, nonatomic) UIImageView *logo;
@property (strong, nonatomic) UITextField *phone;
@property (strong, nonatomic) UITextField *pwd;
@property (strong, nonatomic) UIButton *isYincang;
@property (strong, nonatomic) UIButton *login;
@property (strong, nonatomic) UIButton *agreement;
@property (strong, nonatomic) UIButton *forgetPwd;
@property (strong, nonatomic) UIButton *question;
@end
