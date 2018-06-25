//
//  StoreTableViewCell.m
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "StoreTableViewCell.h"

@interface StoreTableViewCell ()
@property(nonatomic,strong) UIImageView *imageDetails;
@property(nonatomic,strong) UILabel *price;
@property(nonatomic,strong) UIButton *buy;
@end

@implementation StoreTableViewCell

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.imageDetails];
        [self addSubview:self.price];
        [self addSubview:self.buy];
        
        [self setNeedsUpdateConstraints];
        [self updateConstraintsIfNeeded];
    }
    return self;
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.imageDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-10, SCREEN_WIDTH*0.5-10));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.imageDetails.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-15, 20));
    }];
    
    [self.buy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.imageDetails.mas_bottom).with.offset(6);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.5-35, 20));
    }];
}

-(UIImageView *)imageDetails {
    if (!_imageDetails) {
        _imageDetails = [[UIImageView alloc] init];
        _imageDetails.backgroundColor = [UIColor greenColor];
    }
    return _imageDetails;
}

-(UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.font = [UIFont systemFontOfSize:14];
        _price.text = @"112";
    }
    return _price;
}

-(UIButton *)buy {
    if (!_buy) {
        _buy = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buy setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_buy.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_buy setBackgroundColor:[UIColor redColor]];
    }
    return _buy;
}
@end
