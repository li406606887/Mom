//
//  ModifyPayPwdViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ModifyPayPwdViewModel.h"

@implementation ModifyPayPwdViewModel
- (void)initialize {
    @weakify(self)
    [self.modifyPasswordCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.modifyPasswordPwdSubject sendNext:nil];
    }];
}

- (RACCommand *)modifyPasswordCommand {
    if (!_modifyPasswordCommand) {
        _modifyPasswordCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/setPayPassword" withParam:input error:&error];
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
    return _modifyPasswordCommand;
}

- (RACSubject *)modifyPasswordPwdSubject {
    if (!_modifyPasswordPwdSubject) {
        _modifyPasswordPwdSubject = [RACSubject subject];
    }
    return _modifyPasswordPwdSubject;
}

@end
