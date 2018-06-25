//
//  MyWelfareViewModel.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyWelfareViewModel.h"

@implementation MyWelfareViewModel
- (void)initialize {
    @weakify(self)
    [self.getMyWelfareCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        for (NSDictionary *data in x) {
            MyWelfareModel *model = [MyWelfareModel mj_objectWithKeyValues:data];
            [self.dataArray addObject:model];
        }
        [self.getMyWelfareSubject sendNext:nil];
    }];
}

- (RACCommand *)getMyWelfareCommand {
    if (!_getMyWelfareCommand) {
        _getMyWelfareCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/common/getWelfare" withParam:input error:&error];
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
    return _getMyWelfareCommand;
}

- (RACSubject *)getMyWelfareSubject {
    if (!_getMyWelfareSubject) {
        _getMyWelfareSubject = [RACSubject subject];
    }
    return _getMyWelfareSubject;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}
@end
