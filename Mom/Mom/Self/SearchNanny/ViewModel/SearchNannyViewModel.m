//
//  SearchNannyViewModel.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SearchNannyViewModel.h"

@implementation SearchNannyViewModel
- (void)initialize {
    [self.searchCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        [self.dataarray removeAllObjects];
        InvitationNannyModel *model = [InvitationNannyModel mj_objectWithKeyValues:x];
        [self.dataarray addObject:model];
        [self.refreshTableSubject sendNext:nil];
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

- (NSMutableArray *)dataarray {
    if (!_dataarray) {
        _dataarray = [NSMutableArray array];
    }
    return _dataarray;
}
@end
