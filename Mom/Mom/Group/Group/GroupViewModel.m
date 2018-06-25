//
//  GroupViewModel.m
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "GroupViewModel.h"
#import "BannersModel.h"


@implementation GroupViewModel
- (void)initialize {
    @weakify(self)
    [self.getTopCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        for (NSDictionary*data in [x objectForKey:@"list"]) {
            GroupModel *model = [GroupModel mj_objectWithKeyValues:data];
            [self.topArray addObject:model];
        }
        [self.refreshTableSubject sendNext:nil];
    }];
    
    [self.getSquareCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.bannersArray removeAllObjects];
        for (NSDictionary*data in [x objectForKey:@"list"]) {
            GroupModel *model = [GroupModel mj_objectWithKeyValues:data];
            [self.squareArray addObject:model];
        }
        for (NSDictionary*data in [x objectForKey:@"banners"]) {
            BannersModel *model = [BannersModel mj_objectWithKeyValues:data];
            [self.bannersArray addObject:model];
        }
        if (self.bannersArray.count>0) {
            [self.refreshBannersSubject sendNext:nil];
        }
        [self.refreshTableSubject sendNext:nil];
    }];
    
    [self.concernCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        self.selectedModel.isAttention = @"1";
        [self.refreshTableSubject sendNext:nil];
    }];
    
    [self.collectCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.selectedModel.isCollect = @"1";
        [self.refreshTableSubject sendNext:nil];
    }];
    
    [self.cancelConcernCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.selectedModel.isAttention = @"0";
        [self.refreshTableSubject sendNext:nil];
    }];
    
    [self.cancelCollectCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.selectedModel.isCollect = @"0";
        [self.refreshTableSubject sendNext:nil];
    }];
}

- (RACCommand *)collectCommand {
    if (!_collectCommand) {
        _collectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/circle/collect" withParam:input error:&error];
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
    return _collectCommand;
}

- (RACCommand *)cancelCollectCommand {
    if (!_cancelCollectCommand) {
        _cancelCollectCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/circle/cancelCollect" withParam:input error:&error];
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
    return _cancelCollectCommand;
}

- (RACCommand *)concernCommand {
    if (!_concernCommand) {
        _concernCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/circle/attention" withParam:input error:&error];
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
    return _concernCommand;
}

- (RACCommand *)cancelConcernCommand {
    if (!_cancelConcernCommand) {
        _cancelConcernCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/circle/cancelAttention" withParam:input error:&error];
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
    return _cancelConcernCommand;
}

- (RACCommand *)getTopCommand {
    if (!_getTopCommand) {
        _getTopCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/circle/getAttention" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            [self.refreshTableSubject sendNext:nil];
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getTopCommand;
}

- (RACCommand *)getSquareCommand {
    if (!_getSquareCommand) {
        _getSquareCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/circle/get" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            [self.refreshTableSubject sendNext:nil];
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getSquareCommand;
}

- (void)setSelectedModel:(GroupModel *)selectedModel {
    _selectedModel = selectedModel;
}

-(RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

- (RACSubject *)refreshTableSubject {
    if (!_refreshTableSubject) {
        _refreshTableSubject = [RACSubject subject];
    }
    return _refreshTableSubject;
}

- (RACSubject *)refreshBannersSubject {
    if (!_refreshBannersSubject) {
        _refreshBannersSubject = [RACSubject subject];
    }
    return _refreshBannersSubject;
}

- (NSMutableArray *)topArray {
    if (!_topArray) {
        _topArray = [NSMutableArray array];
    }
    return _topArray;
}

- (NSMutableArray *)squareArray {
    if (!_squareArray) {
        _squareArray = [NSMutableArray array];
    }
    return _squareArray;
}

- (NSMutableArray *)bannersArray {
    if (!_bannersArray) {
        _bannersArray = [NSMutableArray array];
    }
    return _bannersArray;
}
@end
