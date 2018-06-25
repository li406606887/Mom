//
//  YLWithdrawViewModel.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLWithdrawViewModel.h"

@implementation YLWithdrawViewModel
//POST /api/user/walletDraw

- (RACCommand *)drawCommand {
    if (!_drawCommand) {
        _drawCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                loading(@"");
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    NSError * error;
                    QHRequestModel *model = [QHRequest postDataWithApi:@"/api/user/walletDraw" withParam:input error:&error];
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
    return _drawCommand;
}
-(RACSubject *)drawBtnClickSubject {
    if (!_drawBtnClickSubject) {
        _drawBtnClickSubject = [RACSubject subject];
    }
    return _drawBtnClickSubject;
}
@end
