//
//  YLBalanceDetailsCell.m
//  DXYiGe
//
//  Created by JHT on 2018/5/23.
//  Copyright © 2018年 QC. All rights reserved.
//

#import "YLBalanceDetailsCell.h"

@interface YLBalanceDetailsCell ()
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UILabel *moneyLabel;
@property (nonatomic,strong) UIView *line;
@end

@implementation YLBalanceDetailsCell
-(void)setModel:(YLBalanceDetailsModel *)model {
    if (model) {
        self.contentLabel.text = model.content;
        self.timeLabel.text = model.createDate;
        if ([model.type isEqualToString:@"1"]) {
           self.moneyLabel.text =  [NSString stringWithFormat:@"+%@",model.money];
        }else {
            self.moneyLabel.text =  [NSString stringWithFormat:@"-%@",model.money];
        }
    }
}
-(void)setupViews {
    
    [self addSubview:self.contentLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.moneyLabel];
    [self addSubview:self.line];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(8);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.bottom.equalTo(self).offset(-8);
    }];
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
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
-(UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.text = @"*****";
        _contentLabel.font = [UIFont systemFontOfSize:16.0f];
        _contentLabel.textColor = RGB(51, 51, 51);
    }
    return _contentLabel;
}
-(UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.text = @"******";
        _timeLabel.font = [UIFont systemFontOfSize:14.0f];
        _timeLabel.textColor = RGB(153, 153, 153);
    }
    return _timeLabel;
}
-(UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.text = @"**";
        _moneyLabel.font = [UIFont systemFontOfSize:20];
        _moneyLabel.textColor = RGB(51, 51, 51);
        _moneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moneyLabel;
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
