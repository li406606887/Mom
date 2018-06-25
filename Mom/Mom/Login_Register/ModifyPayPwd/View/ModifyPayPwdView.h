//
//  ModifyPayPwdView.h
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "ModifyPayPwdViewModel.h"

@interface ModifyPayPwdView : BaseView
@property (strong, nonatomic) ModifyPayPwdViewModel *viewModel;
@property (strong, nonatomic) UITextField *oldPwdField;
@property (strong, nonatomic) UITextField *pwdField;
@property (strong, nonatomic) UITextField *surePwdField;
@property (strong, nonatomic) UIButton *login;
@end
