//
//  SubimitPhotoView.m
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "SubimitPhotoView.h"

@implementation SubimitPhotoView
- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.backView];
        [self addSubview:self.title];
        [self addSubview:self.photoImage];
        [self addSubview:self.sampleImage];
    }
    return self;
}

- (void)layoutSubviews {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(30);
        make.size.mas_offset(CGSizeMake(130, 130));
    }];
    
    [self.sampleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.size.mas_offset(CGSizeMake(130, 130));
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

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

- (UILabel *)title {
    if (!_title) {
        _title = [[UILabel alloc] init];
        [_title setFont:[UIFont systemFontOfSize:14]];
    }
    return _title;
}

- (UIImageView *)photoImage {
    if (!_photoImage) {
        _photoImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"group_upload_add_photo"]];
        _photoImage.backgroundColor = [UIColor whiteColor];
        _photoImage.userInteractionEnabled = YES;
        @weakify(self)
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
         @strongify(self)
            if (self.clickBlock) {
                self.clickBlock();
            }
        }];
        [_photoImage addGestureRecognizer:tap];
    }
    return _photoImage;
}

- (UIImageView *)sampleImage {
    if (!_sampleImage) {
        _sampleImage = [[UIImageView alloc] init];
        _sampleImage.backgroundColor = [UIColor whiteColor];
    }
    return _sampleImage;
}

@end
