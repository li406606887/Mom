//
//  JaundiceRecordViewModel.m
//  Mom
//
//  Created by together on 2018/5/30.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "JaundiceRecordViewModel.h"
#import "JaundiceObserModel.h"

@implementation JaundiceRecordViewModel
- (void)initialize {
    @weakify(self)
    [self.getCurrentRecordCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.dataArray removeAllObjects];
        for (NSDictionary *data in [x objectForKey:@"list"]) {
            JaundiceObserModel *model = [JaundiceObserModel mj_objectWithKeyValues:data];
            [self.dataArray addObject:model];
        }
        [self.refreshTableSubject sendNext:nil];
    }];
}

- (RACCommand *)getCurrentRecordCommand {
    if (!_getCurrentRecordCommand) {
        _getCurrentRecordCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/jaundice/queryAll" withParam:input error:&error];
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
    return _getCurrentRecordCommand;
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
