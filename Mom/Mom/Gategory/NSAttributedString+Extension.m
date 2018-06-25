//
//  NSAttributedString+Extension.m
//  QHTrade
//
//  Created by user on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import "NSAttributedString+Extension.h"

@implementation NSAttributedString (Extension)
+(CGSize)getTextSizeWithText:(NSString *)text withMaxSize:(CGSize)size withLineSpacing:(int)LineSpacing{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    if (LineSpacing!=0) {
        [paragraphStyle setLineSpacing:LineSpacing];
    }
    NSDictionary *attributes = @{ NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rect = [text boundingRectWithSize:size
                                     options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    return rect.size;
}
+(NSMutableAttributedString*)getAttributedStringWithString:(NSString*)string
                                                 frontFont:(CGFloat)front
                                                BehindFont:(CGFloat)behind
                                            frontTextColor:(UIColor*)frontColor
                                               behindColor:(UIColor*)behindColor
                                                     range:(NSRange)range {
    NSMutableParagraphStyle *paragraph = [[NSMutableParagraphStyle alloc] init];
    paragraph.lineSpacing = 2;
    NSDictionary *attributedDic = @{NSFontAttributeName:[UIFont systemFontOfSize:behind],NSForegroundColorAttributeName:behindColor,NSParagraphStyleAttributeName:paragraph};
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributedDic];
    [attributedString addAttribute:NSForegroundColorAttributeName value:frontColor range:range];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:front] range:range];
    return attributedString;
}
@end
