//
//  YLWalletCell.m
//  Mom
//
//  Created by wgz on 2018/5/25.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLWalletCell.h"

@interface YLWalletCell ()
//@property (nonatomic,strong) UILabel *nameLabel;
//@property (nonatomic,strong) UIImageView *imgView;

@property (nonatomic,strong) UIView *line;
@property (nonatomic,strong) UIImageView *arrowImg;
@end

@implementation YLWalletCell

-(void)setupViews {
    [self addSubview:self.nameLabel];
    [self addSubview:self.imgView];
    [self addSubview:self.line];
    [self addSubview:self.arrowImg];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.size.mas_offset(CGSizeMake(160, 20));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(0.5f);
        make.left.equalTo(self).offset(15);
        make.right.equalTo(self).offset(-15);
    }];
    
    [self.arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
        make.size.mas_offset(CGSizeMake(7, 13));
    }];
    
    [super updateConstraints];
    
}

-(UIImageView *)arrowImg {
    if (!_arrowImg) {
        if (!_arrowImg) {
            _arrowImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"self_more"]];// 8*15
        }
    }
    return _arrowImg;
}
-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = RGB(240, 240, 240);
    }
    return _line;
}

-(UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"****";
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
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
