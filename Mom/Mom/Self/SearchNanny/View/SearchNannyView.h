//
//  SearchNannyView.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "SearchNannyViewModel.h"

@interface SearchNannyView : BaseView
@property (strong, nonatomic) SearchNannyViewModel *viewModel;
@property (strong, nonatomic) UIButton *searchBtn;
@property (strong, nonatomic) UITextField *textField;
@end
