//
//  GroupDetailsViewModel.m
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "GroupDetailsViewModel.h"
#import "AnswerModel.h"

@implementation GroupDetailsViewModel
- (void)initialize {
    @weakify(self)
    [self.sendTextCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        loading(@"")
        [self.getDetailsCommand execute:@{@"circleId":self.model.ID,@"offset":@"0",@"limit":@(self.dataArray.count+1)}];
        [self.dataArray removeAllObjects];
    }];
    
    [self.getDetailsCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        hiddenHUD;
        @strongify(self)
        for (NSDictionary *data in [x objectForKey:@"commentList"]) {
            AnswerModel *answer = [AnswerModel mj_objectWithKeyValues:data];
            [self.dataArray addObject:answer];
        }
        [self.refreshSubject sendNext:nil];
    }];
}


- (RACCommand *)sendTextCommand {
    if (!_sendTextCommand) {
        _sendTextCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/circle/comment" withParam:input error:&error];
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
    return _sendTextCommand;
}

- (RACCommand *)getDetailsCommand {
    if (!_getDetailsCommand) {
        _getDetailsCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/circle/view" withParam:input error:&error];
                    dispatch_async(dispatch_get_main_queue(), ^{
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
    return _getDetailsCommand;
}

- (void)setModel:(GroupModel *)model {
    _model = model;
}

- (RACSubject *)refreshSubject {
    if (!_refreshSubject) {
        _refreshSubject = [RACSubject subject];
    }
    return _refreshSubject;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithArray:self.model.commentList];
    }
    return _dataArray;
}
@end
