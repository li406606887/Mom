//
//  AnswerModel.m
//  Mom
//
//  Created by together on 2018/5/24.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "AnswerModel.h"

@implementation AnswerModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"commentList":[AnswerModel class]};
}

- (CGFloat)height {
    if (_height<1) {
        if (_height<1) {
            CGRect rect = [_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-50, MAXFLOAT)
                           
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                           
                                              attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                           
                                                 context:nil];
            int contenheight = ceil(rect.size.height)+5;
            _height = contenheight + 10 +40 +10 +5;
        }
    }
    return _height;

}
@end
