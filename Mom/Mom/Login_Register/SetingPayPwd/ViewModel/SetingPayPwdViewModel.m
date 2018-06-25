//
//  SetingPayPwdViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "SetingPayPwdViewModel.h"

@implementation SetingPayPwdViewModel
- (void)initialize {
    @weakify(self)
    [self.setingPwdCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.setingPwdSubject sendNext:nil];
    }];
    
    
}

- (RACCommand *)setingPwdCommand {
    if (!_setingPwdCommand) {
        _setingPwdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/setPayPassword" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            NSLog(@"%@",error);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _setingPwdCommand;
}

- (RACSubject *)setingPwdSubject {
    if (!_setingPwdSubject) {
        _setingPwdSubject = [RACSubject subject];
    }
    return _setingPwdSubject;
}
@end
