//
//  GroupMoreViewModel.h
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "BaseViewModel.h"

@interface GroupMoreViewModel : BaseViewModel

@property (strong, nonatomic) RACCommand *sendTextCommand;

@property (strong, nonatomic) RACSubject *cellClickSubject;

@property (strong, nonatomic) NSMutableArray *dataArray;
@end
