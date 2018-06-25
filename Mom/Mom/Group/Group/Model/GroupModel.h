//
//  GroupModel.h
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnswerModel.h"

@interface GroupModel : NSObject
@property (copy, nonatomic) NSString *attentionQuantity;
@property (copy, nonatomic) NSString *collectQuantity;
@property (strong, nonatomic) NSArray *commentList;
@property (copy, nonatomic) NSString *commentQuantity;
@property (copy, nonatomic) NSString *content;
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *isAttention;
@property (copy, nonatomic) NSString *isCollect;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *nickName;
@property (copy, nonatomic) NSString *parentId;
@property (copy, nonatomic) NSString *url;
@property (copy, nonatomic) NSString *headUrl;
@property (strong, nonatomic) NSArray *imageList;
@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) CGFloat headHeight;

@end
