//
//  PickerView.h
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataPickerView : UIView<UIPickerViewDelegate>
@property (strong, nonatomic) UIView *backgroundView;

@property (strong, nonatomic) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray* firstArray;

@property (nonatomic, strong) NSArray* sectionArray;

@property (strong, nonatomic) UIButton *selectedBtn;

@property (copy, nonatomic) NSString *firstValue;

@property (copy, nonatomic) NSString *secondValue;

@property (strong, nonatomic) void (^seletedDateBlock)(NSString *first,NSString *second);

- (instancetype)initWithFrame:(CGRect)frame firstArray:(NSArray *)firstArray secondArray:(NSArray*)secondArray;
@end
