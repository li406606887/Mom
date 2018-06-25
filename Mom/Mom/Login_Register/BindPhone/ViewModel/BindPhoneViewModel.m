//
//  BindPhoneViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BindPhoneViewModel.h"

@implementation BindPhoneViewModel
- (void)initialize {
    @weakify(self)
    [self.rebindingPhoneCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [UserInformation getInformation].loginModel = [LoginModel mj_objectWithKeyValues:x];
        [self.rebindingPhoneSubject sendNext:nil];
    }];
    
    [self.getCodeCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.getCodeSubject sendNext:nil];
    }];
}

- (RACCommand *)rebindingPhoneCommand {
    if (!_rebindingPhoneCommand) {
        _rebindingPhoneCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"")
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/thirdPartylogin" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
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
    return _rebindingPhoneCommand;
}

- (RACCommand *)getCodeCommand {
    if (!_getCodeCommand) {
        _getCodeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/sys/sendSms" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD;
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
    return _getCodeCommand;
}

- (RACSubject *)rebindingPhoneSubject {
    if (!_rebindingPhoneSubject) {
        _rebindingPhoneSubject = [RACSubject subject];
    }
    return _rebindingPhoneSubject;
}

- (RACSubject *)getCodeSubject {
    if (!_getCodeSubject) {
        _getCodeSubject = [RACSubject subject];
    }
    return _getCodeSubject;
}
@end
