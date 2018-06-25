//
//  MyBabbyViewModel.m
//  Mom
//
//  Created by together on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyBabbyViewModel.h"

@implementation MyBabbyViewModel

- (void)initialize {
    @weakify(self)
    [self.getMyBabyCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.dataArray removeAllObjects];
        for (NSDictionary *data in x) {
            BabyModel *model = [BabyModel mj_objectWithKeyValues:data];
            [self.dataArray addObject:model];
        }
        [self.refreshTableSubject sendNext:nil];
    }];
}

- (RACCommand *)getMyBabyCommand {
    if (!_getMyBabyCommand) {
        _getMyBabyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/baby/getAllBaby" withParam:input error:&error];
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
    return _getMyBabyCommand;
}

- (RACSubject *)refreshTableSubject {
    if (!_refreshTableSubject) {
        _refreshTableSubject = [RACSubject subject];
    }
    return _refreshTableSubject;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
