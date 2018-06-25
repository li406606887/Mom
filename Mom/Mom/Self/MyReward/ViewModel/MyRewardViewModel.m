//
//  MyRewardViewModel.m
//  Mom
//
//  Created by together on 2018/5/28.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyRewardViewModel.h"
#import "MyRewardModel.h"

@implementation MyRewardViewModel

- (void)initialize {
    @weakify(self)
    [self.getMyRewardCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        for (NSDictionary *data in [x objectForKey:@"list"]) {
            MyRewardModel *model = [MyRewardModel mj_objectWithKeyValues:data];
            [self.myRewardArray addObject:model];
        }
        [self.refreshTableSubject sendNext:nil];
    }];
}

- (RACCommand *)getMyRewardCommand {
    if (!_getMyRewardCommand) {
        _getMyRewardCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/getRewardDetail" withParam:input error:&error];
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
    return _getMyRewardCommand;
}

- (RACSubject *)refreshTableSubject {
    if (!_refreshTableSubject) {
        _refreshTableSubject = [RACSubject subject];
    }
    return _refreshTableSubject;
}

-(NSMutableArray *)myRewardArray {
    if (!_myRewardArray) {
        _myRewardArray = [NSMutableArray array];
    }
    return _myRewardArray;
}
@end
