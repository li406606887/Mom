//
//  YLAccountBindingCell.h
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

typedef NS_ENUM(NSUInteger, TableCellType) {
    TableNormalCell,
    TableNoBindCell,
};

#import "BaseTableViewCell.h"

@interface YLAccountBindingCell : BaseTableViewCell

@property(nonatomic,copy) void (^bindingBlock)(void);
@property (nonatomic,strong) UIImageView *leftImgView;
@property (nonatomic,strong) UILabel *topLabel;

@property (nonatomic,strong) UILabel *accountLabel;
@property (nonatomic,assign) TableCellType cellType;

@end
