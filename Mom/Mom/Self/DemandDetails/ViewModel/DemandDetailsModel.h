//
//  DemandDetailsModel.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InvitationNannyModel.h"

@interface DemandDetailsModel : NSObject
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *demand;
@property (copy, nonatomic) NSString *demandId;
@property (copy, nonatomic) NSString *ID;
@property (strong, nonatomic) InvitationNannyModel *moon;//应聘的状态 1待邀请 2邀请面试 3面试通过 4拒绝面试
@property (copy, nonatomic) NSString *moonId;
@property (copy, nonatomic) NSString *status;
@end

