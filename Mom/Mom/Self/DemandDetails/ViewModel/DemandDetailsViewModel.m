//
//  DemandDetailsViewModel.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "DemandDetailsViewModel.h"
#import "DemandDetailsModel.h"

@implementation DemandDetailsViewModel

- (void)initialize {
    @weakify(self)
    [self.getDemandDetailsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.dataArray removeAllObjects];
        for (NSDictionary *data in [x objectForKey:@"applies"]) {
            DemandDetailsModel *model = [DemandDetailsModel mj_objectWithKeyValues:data];
            [self.dataArray addObject:model];
        }
        [self.refreshTableSubject sendNext:nil];
    }];
    
    [self.getInviteMoonCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.getDemandDetailsCommand execute:nil];
        showMassage(@"邀请成功");
    }];
    
    [self.suspendedDemandCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.model.status = @"2";
        [self.refreshHeadInfoSubject sendNext:nil];
    }];
    
    [self.endDemandCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.model.status = @"3";
        [self.refreshHeadInfoSubject sendNext:nil];
    }];
    
    [self.resumeDemandCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
    @strongify(self)
        self.model.status = @"1";
        [self.refreshHeadInfoSubject sendNext:nil];
    }];
    
    [self.inviteSuccessMoonCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.getDemandDetailsCommand execute:nil];
        showMassage(@"成功通过面试");
    }];
}


- (RACCommand *)getDemandDetailsCommand {
    if (!_getDemandDetailsCommand) {
        _getDemandDetailsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/demand/queryDemandApplyByMother" withParam:@{@"demandId":self.model.ID} error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getDemandDetailsCommand;
}

- (RACCommand *)getInviteMoonCommand {
    if (!_getInviteMoonCommand) {
        _getInviteMoonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/demand/inviteMoon2View" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getInviteMoonCommand;
}

- (RACCommand *)inviteSuccessMoonCommand {
    if (!_inviteSuccessMoonCommand) {
        _inviteSuccessMoonCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/demand/passInterview" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _inviteSuccessMoonCommand;
}

- (RACCommand *)suspendedDemandCommand {
    if (!_suspendedDemandCommand) {
        _suspendedDemandCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/demand/suspendDemand" withParam:@{@"demandId":self.model.ID} error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD
                        if (!error) {
                            [subscriber sendNext:model.content];
                            showMassage(@"您已成功暂停您的需求");
                        }else {
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _suspendedDemandCommand;
}

- (RACCommand *)resumeDemandCommand {
    if (!_resumeDemandCommand) {
        _resumeDemandCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/demand/resumeDemand" withParam:@{@"demandId":self.model.ID} error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD
                        if (!error) {
                            [subscriber sendNext:model.content];
                            showMassage(@"您已成功恢复您的需求");
                        }else {
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _resumeDemandCommand;
}
- (RACCommand *)endDemandCommand {
    if (!_endDemandCommand) {
        _endDemandCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/demand/stopDemand" withParam:@{@"demandId":self.model.ID} error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD
                        if (!error) {
                            [subscriber sendNext:model.content];
                            showMassage(@"您已成功结束您的需求");
                        }else {
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _endDemandCommand;
}

- (void)setModel:(DemandModel *)model {
    _model = model;
}

- (RACSubject *)refreshTableSubject {
    if (!_refreshTableSubject) {
        _refreshTableSubject = [RACSubject subject];
    }
    return _refreshTableSubject;
}
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (RACSubject *)refreshHeadInfoSubject {
    if (!_refreshHeadInfoSubject) {
        _refreshHeadInfoSubject = [RACSubject subject];
    }
    return _refreshHeadInfoSubject;
}

- (RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}
@end
