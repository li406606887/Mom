//
//  PayMoneyViewModel.m
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "PayMoneyViewModel.h"
#import "WXPayModel.h"

@implementation PayMoneyViewModel

- (void)initialize {
    @weakify(self)
    [self.outLinePayCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
        [self.outLinePaySuccessSubject sendNext:nil];
    }];
    
    [self.onliePayCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        WXPayModel *model = [WXPayModel mj_objectWithKeyValues:[x objectForKey:@"wechatData"]];
        [self.onLinePaySuccessSubject sendNext:model];
    }];
}

- (RACCommand *)onliePayCommand {
    if (!_onliePayCommand) {
        _onliePayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/getPayInfo" withParam:input error:&error];
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
    return _onliePayCommand;
}

- (RACCommand *)outLinePayCommand {
    if (!_outLinePayCommand) {
        _outLinePayCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/getPayInfo" withParam:input error:&error];
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
    return _outLinePayCommand;
}

- (RACSubject *)onLinePaySuccessSubject {
    if (!_onLinePaySuccessSubject) {
        _onLinePaySuccessSubject = [RACSubject subject];
    }
    return _onLinePaySuccessSubject;
}

- (RACSubject *)outLinePaySuccessSubject {
    if (!_outLinePaySuccessSubject) {
        _outLinePaySuccessSubject = [RACSubject subject];
    }
    return _onLinePaySuccessSubject;
}
@end
