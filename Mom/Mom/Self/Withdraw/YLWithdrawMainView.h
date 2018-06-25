//
//  YLWithdrawMainView.h
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "UserDataModel.h"
@interface YLWithdrawMainView : BaseView

@property (nonatomic,strong) UserDataModel *userModel;

@property (nonatomic,assign) int rechargeType;
@end
