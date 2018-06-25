//
//  YLRechargeWayCell.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLRechargeWayCell.h"

@interface YLRechargeWayCell ()

//@property (nonatomic,strong) UILabel *nameLabel;
//@property (nonatomic,strong) UIImageView *imgView;
//@property (nonatomic,strong) UILabel *rightLabel;

@property (nonatomic,strong) UIButton *selectBtn;
@property (nonatomic,strong) UIView *line;
@end

@implementation YLRechargeWayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setupViews {
    [self addSubview:self.nameLabel];
    [self addSubview:self.imgView];
    [self addSubview:self.selectBtn];
    [self addSubview:self.line];
    [self addSubview:self.rightLabel];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.selectBtn.mas_right).offset(15);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.size.mas_offset(CGSizeMake(160, 20));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self);
        make.height.mas_equalTo(0.5f);
    }];
    
    [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.left.equalTo(self.nameLabel.mas_right);
    }];
    
    [super updateConstraints];
    
}

-(void)selectClick:(id)sender {
    
}
-(UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"**";
        _rightLabel.font = [UIFont systemFontOfSize:14.0f];
        _rightLabel.textColor = RGB(51, 51, 51);
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}
-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(240, 240, 240);
    }
    return _line;
}
-(UIButton *)selectBtn {
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectBtn setImage:[UIImage imageNamed:@"pay_weixuanzhogn"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"pay_xuanzhogn"] forState:UIControlStateSelected];
    }
    return _selectBtn;
}
-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"**支付";
        _nameLabel.font = [UIFont systemFontOfSize:14.0f];
        _nameLabel.textColor = RGB(51, 51, 51);
    }
    return _nameLabel;
}
-(UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weixin"]];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectBtn.selected = selected;
}


@end
