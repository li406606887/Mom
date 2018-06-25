//
//  YLWalletViewModel.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLWalletViewModel.h"
#import "UserDataModel.h"


@implementation YLWalletViewModel
- (void)initialize {
    WS(weakSelf)
    [self.getDateCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
        if ([x isKindOfClass:[NSDictionary class]]) {
            
            UserDataModel * model = [UserDataModel mj_objectWithKeyValues:x];
//            NSString * balance = [x objectForKey:@"balance"];
            [weakSelf.balanceSubject sendNext:model];
        }
    }];
}
-(RACSubject *)balanceSubject {
    if (!_balanceSubject) {
        _balanceSubject = [RACSubject subject];
    }
    return _balanceSubject;
}
-(RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}
- (RACCommand *)getDateCommand {
    if (!_getDateCommand) {
        _getDateCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest getDataWithApi:@"/api/user/getUserData" withParam:input error:&error];
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
@end
