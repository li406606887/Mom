//
//  GroupViewModel.h
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "BaseViewModel.h"
#import "GroupModel.h"

@interface GroupViewModel : BaseViewModel
@property (strong, nonatomic) RACCommand *getTopCommand;
@property (strong, nonatomic) RACCommand *getSquareCommand;
@property (strong, nonatomic) RACCommand *collectCommand;
@property (strong, nonatomic) RACCommand *cancelCollectCommand;
@property (strong, nonatomic) RACCommand *concernCommand;
@property (strong, nonatomic) RACCommand *cancelConcernCommand;

@property (strong, nonatomic) RACSubject *cellClickSubject;
@property (strong, nonatomic) NSMutableArray *topArray;
@property (strong, nonatomic) NSMutableArray *squareArray;
@property (strong, nonatomic) NSMutableArray *bannersArray;
@property (strong, nonatomic) RACSubject *refreshBannersSubject;
@property (strong, nonatomic) RACSubject *refreshTableSubject;
@property (copy, nonatomic) GroupModel *selectedModel;
@end
