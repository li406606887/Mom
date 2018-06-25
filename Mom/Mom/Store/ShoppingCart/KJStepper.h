//
//  KJStepper.h
//  KenJiao
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KJStepper : UIView
/**  当前值 */
@property(assign,nonatomic) int value;
/**  最小值,默认为0 */
@property(assign,nonatomic) int minimumValue;
/**  最大值,默认为100 */
@property(assign,nonatomic) int maximumValue;
/**  步进值，默认为1 */
@property(assign,nonatomic) int stepValue;
/**  减少按钮 */
@property (strong,nonatomic)UIButton *subBtn;
/**  增加按钮 */
@property (strong,nonatomic)UIButton *addBtn;
/**  显示数据的label*/
@property (strong,nonatomic)UILabel *amountLabel;

/**
 *  创建步进条的类方法
 */
+(instancetype)shareStepper;
@end
