//
//  GroupDetailsViewModel.h
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "BaseViewModel.h"
#import "GroupModel.h"

@interface GroupDetailsViewModel : BaseViewModel

@property (strong, nonatomic) RACCommand *sendTextCommand;

@property (strong, nonatomic) RACCommand *getDetailsCommand;

@property (strong, nonatomic) RACSubject *refreshSubject;

@property (copy, nonatomic) GroupModel *model;

@property (strong, nonatomic) NSMutableArray *dataArray;
@end
