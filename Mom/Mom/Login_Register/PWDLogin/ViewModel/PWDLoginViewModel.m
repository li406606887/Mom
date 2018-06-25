
//
//  PWDLoginViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/3/31.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "PWDLoginViewModel.h"
#import "LoginModel.h"

@implementation PWDLoginViewModel
-(void)initialize {
    @weakify(self)
    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [UserInformation getInformation].loginModel = [LoginModel mj_objectWithKeyValues:x];
        [self.loginSubject sendNext:nil];
    }];
}

- (RACCommand *)loginCommand {
    if (!_loginCommand) {
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/login" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
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
    return _loginCommand;
}

- (RACSubject *)agreementSubject {
    if (!_agreementSubject) {
        _agreementSubject = [RACSubject subject];
    }
    return _agreementSubject;
}

- (RACSubject *)forgetPwdSubject {
    if (!_forgetPwdSubject) {
        _forgetPwdSubject = [RACSubject subject];
    }
    return _forgetPwdSubject;
}

- (RACSubject *)loginSubject {
    if (!_loginSubject) {
        _loginSubject = [RACSubject subject];
    }
    return _loginSubject;
}
@end
