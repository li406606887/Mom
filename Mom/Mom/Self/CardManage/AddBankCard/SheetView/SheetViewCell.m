//
//  SheetViewCell.m
//  Mom
//
//  Created by wgz on 2018/6/7.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SheetViewCell.h"
#import "BankSheetModel.h"

@implementation SheetViewCell

-(void)setupViews {
    [self addSubview:self.contentLabel];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    [super updateConstraints];
}
-(UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"title";
        _contentLabel.font = [UIFont systemFontOfSize:15.0f];
        _contentLabel.textColor = RGB(51, 51, 51);
        _contentLabel.textAlignment =NSTextAlignmentCenter;
        
    }
    return _contentLabel;
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
