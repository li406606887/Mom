//
//  AnswerModel.h
//  Mom
//
//  Created by together on 2018/5/24.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerModel : NSObject
@property (copy, nonatomic) NSString* circleId;
@property (copy, nonatomic) NSArray *commentList;
@property (copy, nonatomic) NSString* content;
@property (copy, nonatomic) NSString* createDate;
@property (copy, nonatomic) NSString* ID;
@property (copy, nonatomic) NSString* modifyDate;
@property (copy, nonatomic) NSString* nickName;
@property (copy, nonatomic) NSString* parentId;
@property (copy, nonatomic) NSString* url;
@property (copy, nonatomic) NSString* userId;
@property (assign, nonatomic) CGFloat height;
@property (copy, nonatomic) NSString *headUrl;
@end
