//
//  JaundiceObservationHeadView.m
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "JaundiceObservationHeadView.h"

@implementation JaundiceObservationHeadView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.headPhoto];
    [self addSubview:self.chestPhoto];
    [self addSubview:self.neckPhoto];
}

- (void)layoutSubviews {
    [self.headPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 180));
    }];
    
    [self.chestPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headPhoto.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 180));
    }];
    
    [self.neckPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chestPhoto.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 180));
    }];
    [super layoutSubviews];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (SubimitPhotoView *)headPhoto {
    if (!_headPhoto) {
        _headPhoto = [[SubimitPhotoView alloc] init];
        _headPhoto.title.text = @"额头";
        _headPhoto.sampleImage.image = [UIImage imageNamed:@"jaundice_head"];
        @weakify(self)
        _headPhoto.clickBlock = ^{
            @strongify(self)
            if (self.uploadImageBlock) {
                self.uploadImageBlock(0);
            }
        };
    }
    return _headPhoto;
}

- (SubimitPhotoView *)chestPhoto {
    if (!_chestPhoto) {
        _chestPhoto = [[SubimitPhotoView alloc] init];
        _chestPhoto.title.text = @"胸口";
        _chestPhoto.sampleImage.image = [UIImage imageNamed:@"jaundice_neck"] ;
        @weakify(self)
        _chestPhoto.clickBlock = ^{
            @strongify(self)
            if (self.uploadImageBlock) {
                self.uploadImageBlock(1);
            }
        };
    }
    return _chestPhoto;
}

- (SubimitPhotoView *)neckPhoto {
    if (!_neckPhoto) {
        _neckPhoto = [[SubimitPhotoView alloc] init];
        _neckPhoto.title.text = @"颈部";
        _neckPhoto.sampleImage.image = [UIImage imageNamed:@"jaundice_chest"];
        @weakify(self)
        _neckPhoto.clickBlock = ^{
            @strongify(self)
            if (self.uploadImageBlock) {
                self.uploadImageBlock(2);
            }
        };
    }
    return _neckPhoto;
}

@end
