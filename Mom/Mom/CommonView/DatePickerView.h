//
//  DatePickerView.h
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DatePickerView : UIView
@property (strong, nonatomic) UIView *backgroundView;

@property (strong, nonatomic) UIDatePicker *pickerView;

@property (strong, nonatomic) UIButton *selectedBtn;

@property (strong, nonatomic) void (^seletedDateBlock)(NSString *date);
@end
