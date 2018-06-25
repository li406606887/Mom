//
//  DemandDetailsViewModel.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseViewModel.h"
#import "DemandModel.h"

@interface DemandDetailsViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getDemandDetailsCommand;

@property (strong, nonatomic) RACCommand *getInviteMoonCommand;

@property (strong, nonatomic) RACCommand *inviteSuccessMoonCommand;

@property (strong, nonatomic) RACCommand *suspendedDemandCommand;

@property (strong, nonatomic) RACCommand *resumeDemandCommand;

@property (strong, nonatomic) RACCommand *endDemandCommand;

@property (strong, nonatomic) RACSubject *refreshTableSubject;

@property (strong, nonatomic) RACSubject *refreshHeadInfoSubject;

@property (strong, nonatomic) RACSubject *cellClickSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;

@property (copy, nonatomic) DemandModel *model;

@end
///app/tk/demand/inviteMoon
