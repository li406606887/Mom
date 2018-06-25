//
//  ForgetPwdViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "ForgetPwdViewModel.h"

@implementation ForgetPwdViewModel
- (void)initialize {
    @weakify(self)
    [self.resetPwdCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.resetPwdSubject sendNext:nil];
    }];
    
    [self.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.getCodeSubject sendNext:nil];
    }];
}

- (RACCommand *)resetPwdCommand {
    if (!_resetPwdCommand) {
        _resetPwdCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/findPassword" withParam:input error:&error];
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
    return _resetPwdCommand;
}

- (RACCommand *)getCodeCommand {
    if (!_getCodeCommand) {
        _getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/sys/sendSms" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD
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
    return _getCodeCommand;
}

- (RACSubject *)agreementSubject {
    if (!_agreementSubject) {
        _agreementSubject = [RACSubject subject];
    }
    return _agreementSubject;
}

- (RACSubject *)resetPwdSubject {
    if (!_resetPwdSubject) {
        _resetPwdSubject = [RACSubject subject];
    }
    return _resetPwdSubject;
}

//- (RACSubject *)refreshCodeSubject{
//    if (!_refreshCodeSubject) {
//        _refreshCodeSubject = [RACSubject subject];
//    }
//    return _refreshCodeSubject;
//}

- (RACSubject *)getCodeSubject {
    if (!_getCodeSubject) {
        _getCodeSubject = [RACSubject subject];
    }
    return _getCodeSubject;
}
@end
