//
//  AddBabyViewModel.m
//  Mom
//
//  Created by together on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "AddBabyViewModel.h"

@implementation AddBabyViewModel

- (void)initialize {
    @weakify(self)
    [self.addBabyCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.addBabySubject sendNext:nil];
    }];
}

- (RACCommand *)addBabyCommand {
    if (!_addBabyCommand) {
        _addBabyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/baby/saveBaby" withParam:input error:&error];
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
    return _addBabyCommand;
}

- (RACCommand *)modifyBabyCommand {
    if (!_modifyBabyCommand) {
        _modifyBabyCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/baby/saveBaby" withParam:input error:&error];
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
    return _modifyBabyCommand;
}

- (RACSubject *)addBabySubject {
    if (!_addBabySubject) {
        _addBabySubject = [RACSubject subject];
    }
    return _addBabySubject;
}
@end
