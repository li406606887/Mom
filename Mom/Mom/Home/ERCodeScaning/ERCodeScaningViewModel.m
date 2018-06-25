//
//  ERCodeScaningViewModel.m
//  FamilyFarm
//
//  Created by user on 2017/10/25.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "ERCodeScaningViewModel.h"
#import "InvitationNannyModel.h"

@implementation ERCodeScaningViewModel

- (void)initialize {
    [self.searchCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        InvitationNannyModel *model = [InvitationNannyModel mj_objectWithKeyValues:x];
        [self.refreshTableSubject sendNext:model];
    }];
}

- (RACCommand *)searchCommand {
    if (!_searchCommand) {
        _searchCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/findMoon" withParam:input error:&error];
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
    return _searchCommand;
}

- (RACSubject *)refreshTableSubject {
    if (!_refreshTableSubject) {
        _refreshTableSubject = [RACSubject subject];
    }
    return _refreshTableSubject;
}

- (RACSubject *)failTableSubject {
    if (!_failTableSubject) {
        _failTableSubject = [RACSubject subject];
    }
    return _failTableSubject;
}
@end
