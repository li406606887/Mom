//
//  SendDemandViewModel.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SendDemandViewModel.h"

@implementation SendDemandViewModel

- (void)initialize {
    @weakify(self)
    [self.getCityCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.cityArray removeAllObjects];
        for (NSDictionary *data in x) {
            ProvinceModel *model = [ProvinceModel mj_objectWithKeyValues:data];
            [self.cityArray addObject:model];
        }
    }];
    
    [self.getProvinceCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.provinceArray removeAllObjects];
        for (NSDictionary *data in x) {
            ProvinceModel *model = [ProvinceModel mj_objectWithKeyValues:data];
            [self.provinceArray addObject:model];
        }
        [self.getProvinceSubject sendNext:nil];
    }];
    
    [self.sendDemandCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [self.refreshTableSubject sendNext:nil];
    }];
}

- (RACCommand *)getCityCommand {
    if (!_getCityCommand) {
        _getCityCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/sys/getCity" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc)
                        }
                        hiddenHUD;
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getCityCommand;
}

- (RACCommand *)getProvinceCommand {
    if (!_getProvinceCommand) {
        _getProvinceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/sys/getCity" withParam:@{@"parentId":@"0"} error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc)
                        }
                        hiddenHUD;
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getProvinceCommand;
}
- (RACCommand *)sendDemandCommand {
    if (!_sendDemandCommand) {
        _sendDemandCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/demand/saveOrUpdateDemand" withParam:input error:&error];
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
    return _sendDemandCommand;
}

- (RACSubject *)refreshTableSubject {
    if (!_refreshTableSubject) {
        _refreshTableSubject = [RACSubject subject];
    }
    return _refreshTableSubject;
}

- (RACSubject *)getProvinceSubject {
    if (!_getProvinceSubject) {
        _getProvinceSubject = [RACSubject subject];
    }
    return _getProvinceSubject;
}

- (NSMutableArray *)provinceArray {
    if (!_provinceArray) {
        _provinceArray = [[NSMutableArray alloc] init];
    }
    return _provinceArray;
}

- (NSMutableArray *)cityArray {
    if (!_cityArray) {
        _cityArray = [[NSMutableArray alloc] init];
    }
    return _cityArray;
}
@end
