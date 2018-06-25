//
//  HotMomTableViewCell.m
//  FamilyFarm
//
//  Created by together on 2018/4/2.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "HotMomTableViewCell.h"

@implementation HotMomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupViews {
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [self addSubview:self.title];
    [self addSubview:self.details];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(15);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    
    [self.details mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];

    [super updateConstraints];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = RGB(51, 51, 51);
    }
    return _title;
}

- (UITextField *)details {
    if (!_details) {
        _details = [[UITextField alloc] init];
        _details.font = [UIFont systemFontOfSize:12];
        _details.textColor = [UIColor lightGrayColor];
        _details.textAlignment = NSTextAlignmentRight;
    }
    return _details;
}

@end

@implementation HotMomTableBtnViewCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setupViews {
    self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    [self addSubview:self.title];
    [self addSubview:self.boy];
    [self addSubview:self.girl];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(20);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    
    [self.boy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.title);
        make.right.equalTo(self.mas_right).with.offset(-30);
        make.size.mas_offset(CGSizeMake(65, 30));
    }];
    
    [self.girl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.title);
        make.right.equalTo(self.boy.mas_left).with.offset(-5);
        make.size.mas_offset(CGSizeMake(65, 30));
    }];
   
    [super updateConstraints];
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:15];
        _title.textColor = RGB(51, 51, 51);
    }
    return _title;
}

- (UIButton *)boy {
    if (!_boy) {
        _boy = [self creatButtonWithTitle:@"小王子" defaultImage:@"Self_Noselected" selectedImage:@"Login_Agreement" tag:0];
    }
    return _boy;
}

- (UIButton *)girl {
    if (!_girl) {
        _girl = [self creatButtonWithTitle:@"小公主" defaultImage:@"Self_Noselected" selectedImage:@"Login_Agreement" tag:1];
    }
    return _girl;
}

- (UIButton *)creatButtonWithTitle:(NSString *)title defaultImage:(NSString*)defaultImage selectedImage:(NSString *)selectedImage tag:(int)tag {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [button setTitleColor:RGB(165, 165, 165) forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:defaultImage] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectedImage] forState:UIControlStateSelected];
    button.tag = tag;
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
     @strongify(self)
        int index = (int)x.tag;
        x.selected = YES;
        switch (index) {
            case 0:
                self.girl.selected = NO;
                break;
            case 1:
                self.boy.selected = NO;
                break;
            default:
                break;
        }
    }];
    return button;
}
@end
