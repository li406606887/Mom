//
//  FarmViewModel.m
//  FamilyFarm
//
//  Created by user on 2017/10/18.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "FarmViewModel.h"
#import "BannerModel.h"
#import "CouponsModel.h"

@implementation FarmViewModel
- (void)initialize {
    @weakify(self)
    [self.getInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        @strongify(self)
        [UserInformation getInformation].userModel = [UserModel mj_objectWithKeyValues:x];
//        [self.refrehViewSubject sendNext:nil];
    }];
    
    [self.getCouponsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        for (NSDictionary *data in [x objectForKey:@"list"]) {
            CouponsModel *model = [CouponsModel mj_objectWithKeyValues:data];
            [self.couponsArray addObject:model];
        }
        [self.refreshProblemSubject sendNext:nil];
    }];
    
    [self.getMainCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if ([x isKindOfClass:[NSDictionary class]]) {
            NSArray * banners = [x objectForKey:@"banners"];
            for (NSDictionary *data in banners) {
                BannerModel *model = [BannerModel mj_objectWithKeyValues:data];
                [self.scrollArray addObject:model];
            }
            [self.refreshScrollUISubject sendNext:nil];
        }
    }];
    
    [self.getProblemCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self.problemArray removeAllObjects];
        for (NSDictionary *data in [x objectForKey:@"list"]) {
            FarmModel *model = [FarmModel mj_objectWithKeyValues:data];
            [self.problemArray addObject:model];
        }
        [self.refreshProblemSubject sendNext:nil];
    }];
    
    [self.joinActivityCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        self.model.status = @"1";
        [self.refreshProblemSubject sendNext:nil];
    }];
    
    [self.getDemandCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSArray *array = [x objectForKey:@"list"];
        if (array.count>0) {
            [self.gotoDemandSubject sendNext:@"1"];
        }else {
            [self.gotoDemandSubject sendNext:@"0"];
        }
    }];
}

- (RACCommand *)getProblemCommand {
    if (!_getProblemCommand) {
        _getProblemCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/activity/get" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
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
    return _getProblemCommand;
}

- (RACCommand *)getCouponsCommand {
    if (!_getCouponsCommand) {
        _getCouponsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/coupon/myCoupon" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
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
    return _getCouponsCommand;
}

- (RACCommand *)joinActivityCommand {
    if (!_joinActivityCommand) {
        _joinActivityCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/activity/apply" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
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
    return _joinActivityCommand;
}

- (RACCommand *)getMainCommand {
    if (!_getMainCommand) {
        _getMainCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/home/getAppMotherHome" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc);
                        }
                        hiddenHUD
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getMainCommand;
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
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc);
                        }
                        hiddenHUD
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getInfoCommand;
}


- (RACCommand *)getDemandCommand {
    if (!_getDemandCommand) {
        _getDemandCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/demand/queryDemandByMother" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            [self.gotoDemandSubject sendNext:@"0"];
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getDemandCommand;
}
- (void)setModel:(FarmModel *)model {
    _model = model;
}

-(NSMutableArray *)scrollArray {
    if (!_scrollArray) {
        _scrollArray = [NSMutableArray array];
    }
    return _scrollArray;
}
-(RACSubject *)refreshScrollUISubject{
    if (!_refreshScrollUISubject) {
        _refreshScrollUISubject = [RACSubject subject];
    }
    return _refreshScrollUISubject;
}

-(RACSubject *)farmHeadItemClickSubject {
    if (!_farmHeadItemClickSubject) {
        _farmHeadItemClickSubject = [RACSubject subject];
    }
    return _farmHeadItemClickSubject;
}

-(RACSubject *)refreshProblemSubject{
    if (!_refreshProblemSubject) {
        _refreshProblemSubject = [RACSubject subject];
    }
    return _refreshProblemSubject;
}

- (NSMutableArray *)problemArray {
    if (!_problemArray) {
        _problemArray = [NSMutableArray array];
    }
    return _problemArray;
}

- (RACSubject *)clickTableSubject {
    if (!_clickTableSubject) {
        _clickTableSubject = [RACSubject subject];
    }
    return _clickTableSubject;
}

- (NSMutableArray *)couponsArray{
    if (!_couponsArray) {
        _couponsArray = [NSMutableArray array];
    }
    return _couponsArray;
}

- (NSMutableArray *)demandArray {
    if (!_demandArray) {
        _demandArray = [NSMutableArray array];
    }
    return _demandArray;
}

- (RACSubject *)moreTableSubject {
    if (!_moreTableSubject) {
        _moreTableSubject = [RACSubject subject];
    }
    return _moreTableSubject;
}

- (RACSubject *)gotoDemandSubject {
    if (!_gotoDemandSubject) {
        _gotoDemandSubject = [RACSubject subject];
    }
    return _gotoDemandSubject;
}
@end
