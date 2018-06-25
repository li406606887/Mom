//
//  JaundiceObserViewModel.m
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "JaundiceObserViewModel.h"
#import "JaundiceObserModel.h"
#import "BabyModel.h"

@implementation JaundiceObserViewModel
- (void)initialize {
    @weakify(self)
    [self.getCreateRecordCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        showMassage(@"上传成功");
        [self.goBackSubject sendNext:nil];
    }];
    
    [self.getCurrentDayCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self.dataArray removeAllObjects];
        for (NSDictionary *data in x) {
            JaundiceObserModel *model = [JaundiceObserModel mj_objectWithKeyValues:data];
            [self.dataArray addObject:model];
        }
        [self.refreshTableSubject sendNext:nil];
    }];
    
    [self.getMyBabyCommand.executionSignals.switchToLatest subscribeNext:^(NSArray * _Nullable x) {
       @strongify(self)
        if (x.count>0) {
            NSDictionary *data = x[0];
            self.model = [BabyModel mj_objectWithKeyValues:data];
        }
        if (self.model) {
            [self.getCurrentDayCommand execute:@{@"babyId":self.model.ID}];
        }
    }];
}

- (RACCommand *)getCreateRecordCommand {
    if (!_getCreateRecordCommand) {
        _getCreateRecordCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/jaundice/createRecord" withParam:input error:&error];
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
    return _getCreateRecordCommand;
}

- (RACCommand *)getCurrentDayCommand {
    if (!_getCurrentDayCommand) {
        _getCurrentDayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/jaundice/queryCurrentDay" withParam:input error:&error];
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
    return _getCurrentDayCommand;
}

- (RACCommand *)getMyBabyCommand {
    if (!_getMyBabyCommand) {
        _getMyBabyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/baby/getAllBaby" withParam:input error:&error];
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
    return _getMyBabyCommand;
}
- (void)setModel:(BabyModel *)model {
    _model = model;
}

- (RACSubject *)refreshTableSubject {
    if (!_refreshTableSubject) {
        _refreshTableSubject = [RACSubject subject];
    }
    return _refreshTableSubject;
}

- (RACSubject *)goBackSubject {
    if (!_goBackSubject) {
        _goBackSubject = [RACSubject subject];
    }
    return _goBackSubject;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
