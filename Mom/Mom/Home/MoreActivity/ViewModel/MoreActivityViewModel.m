//
//  MoreActivityViewModel.m
//  Mom
//
//  Created by together on 2018/6/7.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MoreActivityViewModel.h"

@implementation MoreActivityViewModel
- (void)initialize {
    @weakify(self)
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

@end
