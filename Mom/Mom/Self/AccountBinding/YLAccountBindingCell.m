//
//  YLAccountBindingCell.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLAccountBindingCell.h"

@interface YLAccountBindingCell ()


@property (nonatomic,strong) UIView *line;


@property (nonatomic,strong) UIButton *bindOrNoBtn;
@property (nonatomic,strong) UIImageView *arrowImg;


@end

@implementation YLAccountBindingCell
-(void)bindingClick {
    if (self.bindingBlock) {
        self.bindingBlock();
    }
}
-(void)setCellType:(TableCellType)cellType {
    
    if (cellType == TableNoBindCell) {
        [self.topLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
        }];
        [self.bindOrNoBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
        self.accountLabel .hidden = YES;
    }
    if (cellType == TableNormalCell)
    {
        self.accountLabel .hidden = NO;
        [self.bindOrNoBtn setTitle:@"解除绑定" forState:UIControlStateNormal];
        [self.topLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(8);
        }];
    }
    
}
-(void)setupViews {
    [self addSubview:self.leftImgView];
    [self addSubview:self.topLabel];
    [self addSubview:self.line];
    [self addSubview:self.accountLabel];
    [self addSubview:self.arrowImg];
    [self addSubview:self.bindOrNoBtn];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    
    
    [self.leftImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.size.mas_offset(CGSizeMake(30 , 30));
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(8);
//        make.centerY.equalTo(self);
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
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
        make.size.mas_offset(CGSizeMake(7, 13));
    }];
    
    [self.bindOrNoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.arrowImg.mas_left).offset(-15);
        make.size.mas_offset(CGSizeMake(70 , 35));
    }];
    
    [super updateConstraints];
    
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
-(UIButton *)bindOrNoBtn {
    if (!_bindOrNoBtn) {
        _bindOrNoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bindOrNoBtn setBackgroundColor:[UIColor whiteColor]];
        [_bindOrNoBtn setTitleColor:RGB(153, 153,153) forState:UIControlStateNormal];
        _bindOrNoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        _bindOrNoBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        [_bindOrNoBtn setTitle:@"立即绑定" forState:UIControlStateNormal];
        [_bindOrNoBtn addTarget:self action:@selector(bindingClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bindOrNoBtn;
}
//-(UILabel *)rightLabel {
//    if (!_rightLabel) {
//        _rightLabel = [[UILabel alloc] init];
//        _rightLabel.text = @"绑";
//        _rightLabel.font = [UIFont systemFontOfSize:15.0f];
//        _rightLabel.textColor = RGB(151, 151, 151);
//        _rightLabel.textAlignment = NSTextAlignmentRight;
//    }
//    return _rightLabel;
//}
-(UILabel *)accountLabel {
    if (!_accountLabel) {
        _accountLabel = [[UILabel alloc] init];
        _accountLabel.text = @"";
        _accountLabel.font = [UIFont systemFontOfSize:11.0f];
        _accountLabel.textColor = RGB(151, 151, 151);
    }
    return _accountLabel;
}
-(UILabel *)topLabel {
    if (!_topLabel) {
        _topLabel = [[UILabel alloc] init];
        _topLabel.text = @"类型名称";
        _topLabel.font = [UIFont systemFontOfSize:15.0f];
        _topLabel.textColor = RGB(51, 51, 51);
    }
    return _topLabel;
}


-(UIImageView *)arrowImg {
    if (!_arrowImg) {
        if (!_arrowImg) {
            _arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"self_more"]];// 8*15
        }
    }
    return _arrowImg;
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
