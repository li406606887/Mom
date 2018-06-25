//
//  YLBalanceDetailsViewModel.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLBalanceDetailsViewModel.h"
#import "YLBalanceDetailsModel.h"

@implementation YLBalanceDetailsViewModel
- (void)initialize {
    WS(weakSelf)
    [self.getDateCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        
        if (weakSelf.allDataArray.count != 0) {
            [weakSelf.allDataArray removeAllObjects];
        }
        NSArray * list = [x objectForKey:@"list"];
        
        for (NSDictionary *dic in list) {
            YLBalanceDetailsModel *model = [YLBalanceDetailsModel mj_objectWithKeyValues:dic];
            [weakSelf.allDataArray addObject:model];
        }
        [self.refreshUI sendNext:nil];
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
    
    [self.getInDateCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        
        if (weakSelf.inDataArray.count != 0) {
            [weakSelf.inDataArray removeAllObjects];
        }
        NSArray * list = [x objectForKey:@"list"];
        
        for (NSDictionary *dic in list) {
            YLBalanceDetailsModel *model = [YLBalanceDetailsModel mj_objectWithKeyValues:dic];
            [weakSelf.inDataArray addObject:model];
        }
        [self.refreshUI sendNext:nil];
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
    
    [self.getOutDateCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        
        if (weakSelf.outDataArray.count != 0) {
            [weakSelf.outDataArray removeAllObjects];
        }
        NSArray * list = [x objectForKey:@"list"];
        
        for (NSDictionary *dic in list) {
            YLBalanceDetailsModel *model = [YLBalanceDetailsModel mj_objectWithKeyValues:dic];
            [weakSelf.outDataArray addObject:model];
        }
        [self.refreshUI sendNext:nil];
        [self.refreshEndSubject sendNext:@(FooterRefresh_HasMoreData)];
        
    }];
    
}

/*
 {
 list =     (
 );
 total = 0;
 }
 */

-(RACSubject *)refreshEndSubject {
    if (!_refreshEndSubject) {
        _refreshEndSubject = [RACSubject subject];
    }
    return _refreshEndSubject;
}

-(RACSubject *)refreshUI {
    if (!_refreshUI) {
        _refreshUI = [RACSubject subject];
    }
    return _refreshUI;
}
- (RACCommand *)getInDateCommand {
    if (!_getInDateCommand) {
        _getInDateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/getWalletDetail" withParam:input error:&error];
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
    return _getInDateCommand;
}
- (RACCommand *)getOutDateCommand {
    if (!_getOutDateCommand) {
        _getOutDateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/getWalletDetail" withParam:input error:&error];
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
    return _getOutDateCommand;
}
- (RACCommand *)getDateCommand {
    if (!_getDateCommand) {
        _getDateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/getWalletDetail" withParam:input error:&error];
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
    return _getDateCommand;
}
-(NSMutableArray *)allDataArray {
    if(!_allDataArray) {
        _allDataArray = [NSMutableArray array];
    }
    return _allDataArray;
}
-(NSMutableArray *)inDataArray {
    if(!_inDataArray) {
        _inDataArray = [NSMutableArray array];
    }
    return _inDataArray;
}
-(NSMutableArray *)outDataArray {
    if(!_outDataArray) {
        _outDataArray = [NSMutableArray array];
    }
    return _outDataArray;
}
@end
