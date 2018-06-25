//
//  YLCardManageViewModel.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLCardManageViewModel.h"
#import "YLCardManageModel.h"

@implementation YLCardManageViewModel
- (void)initialize {
    WS(weakSelf)
    [self.getDataCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
            
            if (weakSelf.dataArray.count != 0) {
                [weakSelf.dataArray removeAllObjects];
            }
            
            
            for (NSDictionary *dic in x) {
                YLCardManageModel *model = [YLCardManageModel mj_objectWithKeyValues:dic];
//
                [weakSelf.dataArray addObject:model];
            }
            
            [self.refreshUI sendNext:nil];
            
            [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
}

-(RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}
-(RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}
-(RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
-(RACSubject *)addBtnClickSubject {
    if (!_addBtnClickSubject) {
        _addBtnClickSubject = [RACSubject subject];
    }
    return _addBtnClickSubject;
}

//POST /api/user/deleteUserBankCard
- (RACCommand *)getDataCommand {
    if (!_getDataCommand) {
        _getDataCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/getUserBankCard" withParam:input error:&error];
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
    return _getDataCommand;
}

- (RACCommand *)removeCommand {
    if (!_removeCommand) {
        _removeCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/deleteUserBankCard" withParam:input error:&error];
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
    return _removeCommand;
}

-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
@end
