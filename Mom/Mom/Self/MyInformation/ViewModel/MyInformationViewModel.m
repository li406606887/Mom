
//
//  MyInformationViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "MyInformationViewModel.h"

@implementation MyInformationViewModel
- (void)initialize {
    @weakify(self)
    [self.getInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [UserInformation getInformation].userModel = [UserModel mj_objectWithKeyValues:x];
        [self.saveSuccessSubject sendNext:nil];
    }];
    
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
    
    [self.saveInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.getInfoCommand execute:nil];
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

- (RACCommand *)getInfoCommand {
    if (!_getInfoCommand) {
        _getInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/getUserData" withParam:input error:&error];
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
    return _getInfoCommand;
}

- (RACCommand *)getProvinceCommand {
    if (!_getProvinceCommand) {
        _getProvinceCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {

                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/sys/getCity" withParam:@{@"parentId":@"0"} error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{

                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc)
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getProvinceCommand;
}

- (RACCommand *)saveInfoCommand {
    if (!_saveInfoCommand) {
        _saveInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/setUserData" withParam:input error:&error];
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
    return _saveInfoCommand;
}

- (RACSubject *)saveSuccessSubject {
    if (!_saveSuccessSubject) {
        _saveSuccessSubject = [RACSubject subject];
    }
    return _saveSuccessSubject;
}

- (RACSubject *)getProvinceSubject {
    if (!_getProvinceSubject) {
        _getProvinceSubject = [RACSubject subject];
    }
    return _getProvinceSubject;
}

- (RACSubject *)chooseHeadIconSubject {
    if (!_chooseHeadIconSubject) {
        _chooseHeadIconSubject = [RACSubject subject];
    }
    return _chooseHeadIconSubject;
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
