//
//  AddNannyViewModel.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "AddNannyViewModel.h"

@implementation AddNannyViewModel
- (void)initialize {
    @weakify(self)
    [self.getMayBabyCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.babyArray removeAllObjects];
        for (NSDictionary *data in x) {
            BabyModel *model = [BabyModel mj_objectWithKeyValues:data];
            [self.babyArray addObject:model];
        }
        [self.refreshTableSubject sendNext:nil];
    }];
    
    [self.addOrderCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
       @strongify(self)
        [self.addOrderSuccessSubject sendNext:nil];
    }];
}

- (RACCommand *)getMayBabyCommand {
    if (!_getMayBabyCommand) {
        _getMayBabyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/baby/getAllBaby" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        hiddenHUD
                        if (!error) {
                            [subscriber sendNext:model.content];
                        }else {
                            [self.refreshTableSubject sendNext:nil];
                            showMassage(model.desc);
                        }
                        [subscriber sendCompleted];
                    });
                });
                return nil;
            }];
        }];
    }
    return _getMayBabyCommand;
}

- (RACCommand *)addOrderCommand {
    if (!_addOrderCommand) {
        _addOrderCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/createMoonOrder" withParam:input error:&error];
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
    return _addOrderCommand;
}


-(void)setModel:(InvitationNannyModel *)model {
    _model = model;
}
- (RACSubject *)refreshTableSubject {
    if (!_refreshTableSubject) {
        _refreshTableSubject = [RACSubject subject];
    }
    return _refreshTableSubject;
}

- (RACSubject *)addOrderSuccessSubject {
    if (!_addOrderSuccessSubject) {
        _addOrderSuccessSubject = [RACSubject subject];
    }
    return _addOrderSuccessSubject;
}

- (NSMutableArray *)babyArray {
    if (!_babyArray) {
        _babyArray = [NSMutableArray array];
    }
    return _babyArray;
}
@end
