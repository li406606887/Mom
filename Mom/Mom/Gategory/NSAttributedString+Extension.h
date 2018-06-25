//
//  NSAttributedString+Extension.h
//  QHTrade
//
//  Created by user on 2017/7/6.
//  Copyright © 2017年 qihuo.RDTrade.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (Extension)
+(CGSize)getTextSizeWithText:(NSString *)text withMaxSize:(CGSize)size withLineSpacing:(int)LineSpacing;
+(NSMutableAttributedString*)getAttributedStringWithString:(NSString*)string
                                                 frontFont:(CGFloat)front
                                                BehindFont:(CGFloat)behind
                                            frontTextColor:(UIColor*)frontColor
                                               behindColor:(UIColor*)behindColor
                                                     range:(NSRange)range;
@end
