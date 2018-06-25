//
//  SetingLoginPwdView.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "SetingLoginPwdViewModel.h"

@interface SetingLoginPwdView : BaseView
@property (strong, nonatomic) SetingLoginPwdViewModel *viewModel;
@property (strong, nonatomic) UITextField *pwdField;
@property (strong, nonatomic) UITextField *surePwdField;
@property (strong, nonatomic) UIButton *login;
@end
