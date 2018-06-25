//
//  EvaluationViewModel.m
//  Mom
//
//  Created by together on 2018/6/7.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "EvaluationViewModel.h"

@implementation EvaluationViewModel
- (void)initialize {
    @weakify(self)
    [self.getTagcommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        
    }];
    
    [self.evaluationCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        showMassage(@"评论成功");
        [self.backSubject sendNext:nil];
    }];
}

- (RACCommand *)getTagcommand {
    if (!_getTagcommand) {
        _getTagcommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/getTag" withParam:input error:&error];
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
    return _getTagcommand;
}

- (RACCommand *)evaluationCommand {
    if (!_evaluationCommand) {
        _evaluationCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/tk/moonOrder/assessByMother" withParam:input error:&error];
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
    return _evaluationCommand;
}

- (RACSubject *)tagRefreshSubject {
    if (!_tagRefreshSubject) {
        _tagRefreshSubject = [RACSubject subject];
    }
    return _tagRefreshSubject;
}

- (RACSubject *)backSubject {
    if (!_backSubject) {
        _backSubject = [RACSubject subject];
    }
    return _backSubject;
}
@end
