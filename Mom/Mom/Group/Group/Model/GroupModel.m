//
//  GroupModel.m
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "GroupModel.h"

#define kImageWidth SCREEN_WIDTH * 0.3

@implementation GroupModel
+(NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"commentList":[AnswerModel class]};
}

- (CGFloat)height {
    if (_height<1) {
        CGRect rect = [_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-50, MAXFLOAT)
                       
                                             options:NSStringDrawingUsesLineFragmentOrigin
                       
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}
                       
                                             context:nil];
        int contenheight = ceil(rect.size.height)+5;
        if (_commentList.count>0) {
            if (_commentList.count>1) {
                _height = contenheight + 10 +50 +10 +10 +4 +25 +25 +29 +11+10;//+44+10; 最后的10是为了美观真实高度是去掉的
            }else {
                _height = contenheight + 10 +50 +10 +10 +4 +25 +29+11+10;// +44+10;
            }
        }else {
            _height = contenheight + 10 +50 +10 +10 +10;//+44+10;
        }
    }
    
    return _height;
}
- (CGFloat)headHeight {
    if (_headHeight<1) {
        CGRect rect = [_content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-50, MAXFLOAT)
                       
                                             options:NSStringDrawingUsesLineFragmentOrigin
                       
                                          attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                       
                                             context:nil];
        int contenheight = ceil(rect.size.height)+5;
        _headHeight = contenheight + 10 +50 +10 +10 ;//+44+10;
        if (self.imageList.count>0) {
            _headHeight = _headHeight +10 + kImageWidth;
        }
        if (self.imageList.count>3) {
            _headHeight = _headHeight +10 + kImageWidth;
        }
        if (self.imageList.count>6) {
            _headHeight = _headHeight +10 + kImageWidth;
        }
        
    }
    return _headHeight;
}
@end
