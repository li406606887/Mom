//
//  YLAddBankCardTextfieldCell.h
//  Mom
//
//  Created by wgz on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseTableViewCell.h"

#import "YLFillInfoCreatTableModel.h"
@interface YLAddBankCardTextfieldCell : BaseTableViewCell
@property (nonatomic,strong) YLFillInfoCreatTableModel *creatTableModel;
@property (nonatomic,weak) NSDictionary *formDict;

@property (nonatomic,copy) void (^clickBlock) (NSString * str);
@property (nonatomic,strong) UITextField *textField;

//方便外部把控好输入框
- (void)textFieldAddObserver:(id)observer selector:(SEL)selector;
@end
