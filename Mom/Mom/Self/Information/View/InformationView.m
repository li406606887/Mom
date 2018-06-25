//
//  InformationView.m
//  FamilyFarm
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "InformationView.h"

@implementation InformationView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (InformationViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
- (void)setupViews {
    [self addSubview:self.tryingToConceive];
    [self addSubview:self.pregnancy];
    [self addSubview:self.hotMom];
    
    [self setNeedsUpdateConstraints];
}

- (void)updateConstraints {
    [super updateConstraints];
    CGFloat width = 300/(SCREEN_WIDTH-50);
    [self.tryingToConceive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(40);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, width*120));
    }];
    
    [self.pregnancy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tryingToConceive.mas_bottom).with.offset(40);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, width*120));
    }];
    
    [self.hotMom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pregnancy.mas_bottom).with.offset(40);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-50, width*120));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (UIImageView *)tryingToConceive {
    if (!_tryingToConceive) {
        _tryingToConceive = [self creatButtonWithImage:@"Self_Information_TryingToConceive" tag:1];
    }
    return _tryingToConceive;
}

-(UIImageView *)pregnancy {
    if (!_pregnancy) {
        _pregnancy = [self creatButtonWithImage:@"Self_Information_pregnancy" tag:2];
    }
    return _pregnancy;
}

-(UIImageView *)hotMom {
    if (!_hotMom) {
        _hotMom = [self creatButtonWithImage:@"Self_Information_hotMom" tag:3];
    }
    return _hotMom;
}

- (UIImageView *)creatButtonWithImage:(NSString *)image tag:(int)tag {
    UIImageView *button = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:image]resizableImageWithCapInsets:UIEdgeInsetsMake(24, 275, 90, 20) resizingMode:UIImageResizingModeStretch]];
    button.tag = tag;
    button.userInteractionEnabled = YES;
    @weakify(self)
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
        @strongify(self)
        self.viewModel.state = (int)x.view.tag;
        [self.viewModel.setIdentityCommand execute:@{@"identity":@(self.viewModel.state)}];
    }];
    [button addGestureRecognizer:tap];
    return button;
}
@end
