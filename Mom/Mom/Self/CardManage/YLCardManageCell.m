//
//  YLCardManageCell.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLCardManageCell.h"

@interface YLCardManageCell ()
@property (nonatomic,strong) UIImageView *leftImgView;
@property (nonatomic,strong) UILabel *bankLabel;
@property (nonatomic,strong) UILabel *accountLabel;

@property (nonatomic,strong) UIView *line;

@end

@implementation YLCardManageCell

-(void)setupViews {
    [self addSubview:self.leftImgView];
    [self addSubview:self.bankLabel];
    [self addSubview:self.line];
    [self addSubview:self.accountLabel];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    

    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.size.mas_offset(CGSizeMake(30 , 30));
    }];
    [self.bankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
        make.left.equalTo(self.leftImgView.mas_right).offset(15);
        make.height.mas_offset(20);
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5f);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
    
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-8);
        make.left.equalTo(self.leftImgView.mas_right).offset(15);
        make.height.mas_offset(20);
    }];
    
    [super updateConstraints];
    
}
-(void)setModel:(YLCardManageModel *)model {
    if (model) {
        self.accountLabel.text = model.bankNo;
        self.bankLabel.text = model.bankName;
        [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:model.bankLogo] placeholderImage:[UIImage imageNamed:@"self_wei"]];
    }
}
-(UIImageView *)leftImgView {
    if (!_leftImgView) {
        _leftImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"self_weixin"]];// 8*15
        _leftImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _leftImgView;
}
-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(240, 240, 240);
    }
    return _line;
}
-(UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] init];
        _accountLabel.text = @"银行账号";
        _accountLabel.font = [UIFont systemFontOfSize:11.0f];
        _accountLabel.textColor = RGB(151, 151, 151);
    }
    return _accountLabel;
}
-(UILabel *)bankLabel {
    if (!_bankLabel) {
        _bankLabel = [[UILabel alloc] init];
        _bankLabel.text = @"银行名称";
        _bankLabel.font = [UIFont systemFontOfSize:15.0f];
        _bankLabel.textColor = RGB(51, 51, 51);
    }
    return _bankLabel;
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
