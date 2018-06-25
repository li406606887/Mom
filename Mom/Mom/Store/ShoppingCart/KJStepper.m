//
//  KJStepper.m
//  KenJiao
//
//  Created by mac on 16/3/1.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "KJStepper.h"

@implementation KJStepper

+(instancetype)shareStepper{
    
    return [[KJStepper alloc]init];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //设置背景图片
        self.layer.borderColor = RGB(220, 220, 220).CGColor;
        self.layer.borderWidth = 1.0;
        self.layer.cornerRadius = 2.5;
        self.layer.masksToBounds = YES;
        self.clipsToBounds = YES;
        
        //设置默认值
        _value = 0;
        _minimumValue = 0;
        _maximumValue = 100;
        _stepValue = 1;
        
        //创建增减按钮
        _subBtn = [[UIButton alloc]init];
        [_subBtn addTarget:self action:@selector(subValue:) forControlEvents:UIControlEventTouchUpInside];
        [_subBtn setImage:[UIImage imageNamed:@"jian"] forState:UIControlStateNormal];
        [_subBtn setImage:[UIImage imageNamed:@"jian"] forState:UIControlStateHighlighted];
        [self addSubview:_subBtn];
        
        _addBtn = [[UIButton alloc]init];
        [_addBtn addTarget:self action:@selector(addValue:) forControlEvents:UIControlEventTouchUpInside];
        [_addBtn setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateNormal];
        [_addBtn setImage:[UIImage imageNamed:@"jia"] forState:UIControlStateHighlighted];
        [self addSubview:_addBtn];
        
        //创建显示数据的标签
        _amountLabel = [[UILabel alloc]init];
        _amountLabel.layer.borderColor = RGB(220, 220, 220).CGColor;
        _amountLabel.layer.borderWidth = 1.0;
        _amountLabel.textColor = [UIColor blackColor];
        _amountLabel.textAlignment = NSTextAlignmentCenter;
        _amountLabel.text = [NSString stringWithFormat:@"%d",_value];
        [self addSubview:_amountLabel];
    }
    return self;
}

#pragma mark - subValue
-(void)subValue:(UIButton *)btn{
    
    if (_value == 0) return;
    _value --;
    _amountLabel.text = [NSString stringWithFormat:@"%d",_value];
}

#pragma mark - addValue
-(void)addValue:(UIButton *)btn{
    
    if (_value == 100) return;
    _value ++;
    _amountLabel.text = [NSString stringWithFormat:@"%d",_value];
}

//布局子视图frame
-(void)layoutSubviews{
    [super layoutSubviews];
    
    //减按钮
    _subBtn.frame = CGRectMake(0, 0, 30, self.frame.size.height);
    
    //标签
    _amountLabel.frame = CGRectMake(CGRectGetMaxX(_subBtn.frame), 0,self.frame.size.width-60, self.frame.size.height);
    
    //增按钮
    _addBtn.frame = CGRectMake(self.frame.size.width-30, 0, 30, self.frame.size.height);
}
@end
