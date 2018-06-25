//
//  FriendsCircleDetailsHeadView.m
//  FamilyFarm
//
//  Created by user on 2017/10/31.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "FriendsCircleDetailsHeadView.h"
#import "FriendsCircleDetailsViewModel.h"

@interface FriendsCircleDetailsHeadView ()
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UILabel *name;
@property(nonatomic,strong) UILabel *grade;
@property(nonatomic,strong) UILabel *content;
@property(nonatomic,strong) UIImageView *imageDetails;
@property(nonatomic,strong) FriendsCircleDetailsViewModel *viewModel;
@end

@implementation FriendsCircleDetailsHeadView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (FriendsCircleDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.icon];
    [self addSubview:self.name];
    [self addSubview:self.grade];
    [self addSubview:self.content];
    [self addSubview:self.imageDetails];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.icon.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 20));
    }];

    [self.grade mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.name.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 20));
    }];

    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.grade.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 100));
    }];

    [self.imageDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.content.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-20, 200));
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.backgroundColor = [UIColor greenColor];
        _icon.layer.cornerRadius = 30;
        _icon.layer.masksToBounds = YES;
    }
    return _icon;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        [_name setFont:[UIFont systemFontOfSize:14]];
        _name.text = @"i'm tank";
        _name.textAlignment = NSTextAlignmentCenter;
    }
    return _name;
}

-(UILabel *)grade {
    if (!_grade) {
        _grade = [[UILabel alloc] init];
        [_grade setFont:[UIFont systemFontOfSize:14]];
        _grade.text = @"明启小学五年三班";
        _grade.textAlignment = NSTextAlignmentCenter;
    }
    return _grade;
}

-(UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        [_content setFont:[UIFont systemFontOfSize:14]];
        _content.text = @"i'm young I'm coffee";
        _content.textAlignment = NSTextAlignmentCenter;
    }
    return _content;
}

-(UIImageView *)imageDetails {
    if (!_imageDetails) {
        _imageDetails =[[UIImageView alloc] init];
        [_imageDetails setBackgroundColor:[UIColor greenColor]];
    }
    return _imageDetails;
}
@end
