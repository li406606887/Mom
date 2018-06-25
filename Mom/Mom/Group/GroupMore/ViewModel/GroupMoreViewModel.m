//
//  GroupMoreViewModel.m
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "GroupMoreViewModel.h"

@implementation GroupMoreViewModel
- (void)initialize {
    
}

- (RACCommand *)sendTextCommand {
    if (!_sendTextCommand) {
        _sendTextCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            
            return nil;
        }];
    }
    return _sendTextCommand;
}

-(RACSubject *)cellClickSubject {
    if (!_cellClickSubject) {
        _cellClickSubject = [RACSubject subject];
    }
    return _cellClickSubject;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
