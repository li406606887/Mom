//
//  YLAddBankCardTextfieldCell.m
//  Mom
//
//  Created by wgz on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLAddBankCardTextfieldCell.h"

@interface YLAddBankCardTextfieldCell ()<UITextFieldDelegate>
@property (nonatomic,strong) UILabel *leftLabel;
@property (nonatomic,strong) UIView *line;


@end

@implementation YLAddBankCardTextfieldCell
#pragma mark --textField添加通知回调
- (void)textFieldAddObserver:(id)observer selector:(SEL)selector
{
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:selector name:UITextFieldTextDidChangeNotification object:self.textField];
}

- (void)setCreatTableModel:(YLFillInfoCreatTableModel *)creatTableModel
{
    _creatTableModel = creatTableModel;
    
    self.leftLabel.text = creatTableModel.title;
    self.textField.placeholder = creatTableModel.placeholder;
}

- (void)setFormDict:(NSMutableDictionary *)formDict
{
    _formDict = formDict;
    self.textField.text = [formDict valueForKey:self.creatTableModel.key];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    if ([self.creatTableModel.key isEqualToString:@"bankName"]) {
        [textField resignFirstResponder];
        [_textField resignFirstResponder];
        
        if (self.clickBlock) {
            self.clickBlock(@"bankName");
        }
    }

}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if ([self.creatTableModel.key isEqualToString:@"bankName"]) {
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //敲删除键
    if ([string length]==0) {
        return YES;
    }
    
    int index = 30;
    if ([self.creatTableModel.key isEqualToString:@"idcard"]) {
        index = 18;
    }
    if ([self.creatTableModel.key isEqualToString:@"phone"]) {
        index = 11;
    }
 
    //当输入框当前的字符个数大于18的时候，就不让更改了（不能等于18，因为如果等于18，在输入框字符个数等于18的情况下就不能进行粘贴替换内容了）
    if ([textField.text length]>index)
        return NO;
    //获得当前输入框内的字符串
    NSMutableString *fieldText=[NSMutableString stringWithString:textField.text];
    //完成输入动作，包括输入字符，粘贴替换字符
    [fieldText replaceCharactersInRange:range withString:string];
    NSString *finalText=[fieldText copy];
    //如果字符个数大于18就要进行截取前边18个字符
    if ([finalText length]>index) {
        textField.text=[finalText substringToIndex:index];
        return NO;
    }
    
    return YES;
    
}

//将输入的内容保存到formDict里面
- (void)textFieldValueChanged:(NSNotification *)note
{
    if (!self.creatTableModel) {
        return;
    }
    [self.formDict setValue:self.textField.text forKey:self.creatTableModel.key];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    
}

-(UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldValueChanged:) name:UITextFieldTextDidChangeNotification object:_textField];
        _textField.delegate = self;
    }
    return _textField;
}
-(void)setupViews {
    [self addSubview:self.line];
    [self addSubview:self.leftLabel];
    [self addSubview:self.textField];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    
    
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.size.mas_offset(CGSizeMake(100 , 30));
    }];

    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.leftLabel.mas_right).offset(15);
        make.right.equalTo(self);
        make.height.mas_offset(40);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5f);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
    
    
    [super updateConstraints];
    
}


-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(240, 240, 240);
    }
    return _line;
}
-(UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.text = @"title";
        _leftLabel.font = [UIFont systemFontOfSize:16.0f];
        _leftLabel.textColor = RGB(51, 51, 51);
    }
    return _leftLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
