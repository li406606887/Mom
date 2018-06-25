//
//  GroupDetailsToolView.h
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "BaseView.h"
#import "GroupDetailsViewModel.h"

@interface GroupDetailsToolView : BaseView <UITextFieldDelegate>
@property (strong, nonatomic) UIImageView *headIcon;

@property (strong, nonatomic) UITextField *textFile;

@property (strong, nonatomic) UIButton *send;

@property (strong, nonatomic) GroupDetailsViewModel *viewModel;
@end
