//
//  LoginViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/3/29.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "LoginViewModel.h"

@implementation LoginViewModel
- (void)initialize {
    @weakify(self)
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [LoginModel mj_objectWithKeyValues:x];
        [self.loginSubject sendNext:nil];
    }];
    
    [self.getLoginCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self.verificationSubject sendNext:nil];
    }];
    
    [self.getWXIDCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [LoginModel mj_objectWithKeyValues:x];
        [self.getInfoCommand execute:nil];
    }];
    
    [self.getInfoCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [UserModel mj_objectWithKeyValues:x];
        [self.getWXIDSubject sendNext:nil];
    }];
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/login" withParam:input error:&error];
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
    return _loginCommand;
}

- (RACCommand *)getWXIDCommand {
    if (!_getWXIDCommand) {
        _getWXIDCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/thirdPartylogin" withParam:input error:&error];
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
    return _getWXIDCommand;
}

- (RACCommand *)getInfoCommand {
    if (!_getInfoCommand) {
        _getInfoCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/getUserData" withParam:input error:&error];
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
    return _getInfoCommand;
}

- (RACCommand *)getLoginCodeCommand {
    if (!_getLoginCodeCommand) {
        _getLoginCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/sys/sendSms" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            showMassage(model.desc);
                        }
                        hiddenHUD;
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getLoginCodeCommand;
}

- (RACSubject *)loginSubject {
    if (!_loginSubject) {
        _loginSubject = [RACSubject subject];
    }
    return _loginSubject;
}

- (RACSubject *)verificationSubject {
    if (!_verificationSubject) {
        _verificationSubject = [RACSubject subject];
    }
    return _verificationSubject;
}

- (RACSubject *)agreementSubject {
    if (!_agreementSubject) {
        _agreementSubject = [RACSubject subject];
    }
    return _agreementSubject;
}

- (RACSubject *)pwdLoginSubject {
    if (!_pwdLoginSubject) {
        _pwdLoginSubject = [RACSubject subject];
    }
    return _pwdLoginSubject;
}

- (RACSubject *)otherWayLoginSubject {
    if (!_otherWayLoginSubject) {
        _otherWayLoginSubject = [RACSubject subject];
    }
    return _otherWayLoginSubject;
}

- (RACSubject *)getWXIDSubject {
    if (!_getWXIDSubject) {
        _getWXIDSubject = [RACSubject subject];
    }
    return _getWXIDSubject;
}
@end
