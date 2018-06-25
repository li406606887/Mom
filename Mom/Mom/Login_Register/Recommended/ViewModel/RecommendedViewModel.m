//
//  RecommendedViewModel.m
//  FamilyFarm
//
//  Created by together on 2018/4/1.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "RecommendedViewModel.h"

@implementation RecommendedViewModel
- (void)initialize {
    @weakify(self)
    [self.bindReferrerCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self.bindReferrerSubject sendNext:nil];
    }];
    
    
}

- (RACCommand *)bindReferrerCommand {
    if (!_bindReferrerCommand) {
        _bindReferrerCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/setUserData" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
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
    return _bindReferrerCommand;
}

- (RACSubject *)bindReferrerSubject {
    if (!_bindReferrerSubject) {
        _bindReferrerSubject = [RACSubject subject];
    }
    return _bindReferrerSubject;
}
@end
