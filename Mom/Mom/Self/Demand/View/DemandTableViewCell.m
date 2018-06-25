//
//  DemandTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/21.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "DemandTableViewCell.h"

@implementation DemandTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setModel:(DemandModel *)model {
    _model = model;
    NSString *babyNum;
    if ([model.babyType intValue] == 1) {
        babyNum = @"单胞胎";
    } else if ([model.babyType intValue] == 2) {
        babyNum = @"双胞胎";
    } else {
        babyNum = @"多胞胎";
    }
//    护理周期:
    self.demandTitle.text = [NSString stringWithFormat:@"预产期:%@|%@天",model.dueDate,model.serviceDay];
    self.markInfo.text = [NSString stringWithFormat:@"需求:%@人 %@岁-%@岁 %@经验",model.moonAddr,model.moonAgeMin,model.moonAgeMax,model.moonExp];
    self.browseDetails.text = [NSString stringWithFormat:@"%@人投递 %@人浏览",model.joinCount,model.viewCount];
    NSString *btnTitle ;
    switch ([model.status intValue]) {
        case 1:
            btnTitle = [NSString stringWithFormat:@"应聘中"];
            break;
        case 2:
            btnTitle = [NSString stringWithFormat:@"暂停中"];
            break;
        case 3:
            btnTitle = [NSString stringWithFormat:@"已结束"];
            break;
        default:
            break;
    }
    [self.stateBtn setTitle:btnTitle forState:UIControlStateNormal];
}

@end


@implementation DemandCityChooseCell

-(void)setupViews {
    [self addSubview:self.title];
    [self addSubview:self.address];
    [self addSubview:self.all];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(100, 30));
    }];
    
    [self.address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.all.mas_left).with.offset(-8);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(80, 25));
    }];
    
    [self.all mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(60, 25));
    }];
    [super updateConstraints];
}


-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = [UIColor darkGrayColor];
    }
    return _title;
}

- (UIButton *)all {
    if (!_all) {
        _all = [self creatButtonWithTitle:@"全部" tag:1];
        _all.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        _all.imageEdgeInsets = UIEdgeInsetsMake(0, 45, 0, 0);
        @weakify(self)
        [[_all rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.cityBlock();
        }];
    }
    return _all;
}

- (UIButton *)address {
    if (!_address) {
        _address = [self creatButtonWithTitle:@"选择省市" tag:0];
        _address.titleEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0);
        _address.imageEdgeInsets = UIEdgeInsetsMake(0, 60, 0, 0);
        @weakify(self)
        [[_address rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            self.provinceBlock();
        }];
    }
    return _address;
}


- (UIButton *)creatButtonWithTitle:(NSString *)title tag:(int)tag  {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 3;
    button.layer.borderWidth = 0.5;
    button.layer.borderColor = RGB(200, 200, 200).CGColor;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [button setImage:[UIImage imageNamed:@"Self_Menu_Down"] forState:UIControlStateNormal];
    return button;
}
@end
