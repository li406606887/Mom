//
//  MyNannyDetailsViewModel.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyNannyDetailsViewModel.h"

@implementation MyNannyDetailsViewModel///api/tk/moonOrder/getOrder
- (void)initialize {
    @weakify(self)
    [self.getOrderCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.dataArray removeAllObjects];
        for (NSDictionary *data in [x objectForKey:@"babies"]) {
            BabyModel *model = [BabyModel mj_objectWithKeyValues:data];
            [self.dataArray addObject:model];
        }
        [self.getOrderSuccessSubject sendNext:nil];
    }];
}

- (RACCommand *)getOrderCommand {
    if (!_getOrderCommand) {
        _getOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/getOrder" withParam:input error:&error];
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
    return _getOrderCommand;
}

- (RACSubject *)getOrderSuccessSubject {
    if (!_getOrderSuccessSubject) {
        _getOrderSuccessSubject = [RACSubject subject];
    }
    return _getOrderSuccessSubject;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (RACSubject *)evaluationSubject {
    if (!_evaluationSubject) {
        _evaluationSubject = [RACSubject subject];
    }
    return _evaluationSubject;
}
@end
