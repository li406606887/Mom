//
//  WeChatShareView.h
//  Nanny
//
//  Created by together on 2018/6/21.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeChatShareView : UIView
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UIView *lineView;
@property (strong, nonatomic) UIButton *refresh;
@property (strong, nonatomic) UIButton *copyurlBtn;
@property (strong, nonatomic) UIButton *group;
@property (strong, nonatomic) UIButton *wechat;
@property (strong, nonatomic) UIButton *cancel;
@property (copy, nonatomic) void(^clickBlock) (int index);
@end
