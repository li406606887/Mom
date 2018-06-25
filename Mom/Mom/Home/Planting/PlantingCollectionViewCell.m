//
//  PlantingCollectionViewCell.m
//  FamilyFarm
//
//  Created by user on 2017/11/1.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "PlantingCollectionViewCell.h"

@interface PlantingCollectionViewCell ()
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,assign) CGFloat width;
@end

@implementation PlantingCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChildView];
//        self.width = ;
        [self.contentView setBackgroundColor:[UIColor yellowColor]];
        NSLog(@"%f",self.width);
    }
    return self;
}

-(void)addChildView {
    [self.contentView addSubview:self.imageView];
    [self.contentView addSubview:self.title];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH * 0.5 -15 , SCREEN_WIDTH * 0.5 -15));
    }];

    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.imageView.mas_bottom).with.offset(5);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH * 0.5 -15, 20));
    }];
}

-(UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor greenColor];
    }
    return _imageView;
}

-(UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = [UIFont systemFontOfSize:14];
        _title.text = @"咯咯咯咯咯咯哒";
        _title.textAlignment = NSTextAlignmentCenter ;
    }
    return _title;
}
@end
