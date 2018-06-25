//
//  ProvinceModel.h
//  PrettyNanny
//
//  Created by together on 2018/4/30.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProvinceModel : NSObject
@property (copy, nonatomic) NSString *createDate;
@property (copy, nonatomic) NSString *modifyDate;
@property (copy, nonatomic) NSString *ID;
@property (copy, nonatomic) NSString *parentId;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *sort;

@end
