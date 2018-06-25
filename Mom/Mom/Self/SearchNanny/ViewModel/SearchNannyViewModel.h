//
//  SearchNannyViewModel.h
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "InvitationNannyModel.h"


@interface SearchNannyViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *searchCommand;
@property (strong, nonatomic) RACSubject *refreshTableSubject;
@property (strong, nonatomic) NSMutableArray *dataarray;
@end
