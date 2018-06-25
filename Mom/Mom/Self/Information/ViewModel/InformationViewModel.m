//
//  InformationViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "InformationViewModel.h"

@implementation InformationViewModel
- (void)initialize {
    @weakify(self)
    [self.setIdentityCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [UserInformation getInformation].userModel.identity = [NSString stringWithFormat:@"%d",self.state];
        [self.setIdentitySubject sendNext:@(self.state)];
    }];
}

- (RACCommand *)setIdentityCommand {
    if (!_setIdentityCommand) {
        _setIdentityCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/setUserData" withParam:input error:&error];
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
    return _setIdentityCommand;
}

-(RACSubject *)setIdentitySubject {
    if (!_setIdentitySubject) {
        _setIdentitySubject = [RACSubject subject];
    }
    return _setIdentitySubject;
}
@end
