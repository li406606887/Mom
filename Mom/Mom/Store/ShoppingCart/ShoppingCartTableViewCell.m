//
//  ShoppingCartTableViewCell.m
//  FamilyFarm
//
//  Created by user on 2017/10/30.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"
#import "KJStepper.h"

@interface ShoppingCartTableViewCell ()
@property(nonatomic,strong) UIButton *choose;
@property(nonatomic,strong) UIImageView *goodImage;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) KJStepper *stepper;
@property(nonatomic,strong) UILabel *price;
@property(nonatomic,strong) UIButton *delete;

@end

@implementation ShoppingCartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setupViews {
    [self.contentView addSubview:self.choose];
    [self.contentView addSubview:self.goodImage];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.stepper];
    [self.contentView addSubview:self.price];
    [self.contentView addSubview:self.delete];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.choose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
    
    [self.goodImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.choose.mas_right).with.offset(10);
        make.centerY.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(80, 80));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImage.mas_right).with.offset(6);
        make.top.equalTo(self.goodImage);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-200, 20));
    }];
    
    [self.stepper mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goodImage.mas_right).with.offset(6);
        make.bottom.equalTo(self.goodImage.mas_bottom);
        make.size.mas_offset(CGSizeMake(100, 30));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.contentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(50, 20));
    }];
    
    [self.delete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).with.offset(-10);
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.size.mas_offset(CGSizeMake(30, 30));
    }];
}


-(UIButton *)choose {
    if (!_choose) {
        _choose = [UIButton buttonWithType:UIButtonTypeCustom];
        [_choose setBackgroundColor:[UIColor greenColor]];
    }
    return _choose;
}

-(UIImageView *)goodImage {
    if (!_goodImage) {
        _goodImage = [[UIImageView alloc] init];
        _goodImage.backgroundColor = [UIColor greenColor];
    }
    return _goodImage;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.text = @"22211";
    }
    return _name;
}

-(KJStepper *)stepper {
    if (!_stepper) {
        _stepper = [[KJStepper alloc] init];
    }
    return _stepper;
}

-(UILabel *)price {
    if (!_price) {
        _price = [[UILabel alloc] init];
        _price.font = [UIFont systemFontOfSize:14];
        _price.text = @"11";
    }
    return _price;
}

-(UIButton *)delete {
    if (!_delete) {
        _delete = [UIButton buttonWithType:UIButtonTypeCustom];
        [_delete setBackgroundColor:[UIColor greenColor]];
    }
    return _delete;
}
@end
