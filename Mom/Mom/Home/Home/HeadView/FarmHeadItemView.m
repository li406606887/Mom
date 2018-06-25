//
//  FarmHeadItemView.m
//  FamilyFarm
//
//  Created by user on 2017/10/19.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "FarmHeadItemView.h"

@implementation FarmHeadItemView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (FarmViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

-(void)setupViews {
    [self addSubview:self.backView];
    [self addItemView];
}

-(void)updateConstraints {
    [super updateConstraints];
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 80));
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)addItemView {
    CGFloat kWidth = 60;
    NSArray *titleArray = [[NSArray alloc] initWithObjects:@"福利",@"扫一扫",@"黄疸检测",@"发布需求", nil];
    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"self_my_welfare",@"Home_HeadItem_Scanning",@"home_jaundice_obser",@"home_senddemand", nil];
    for (int i = 0 ; i < 4;i++) {
        UIButton *item = [self creatButtonWithTitle:titleArray[i] image:imageArray[i]];
        [self.backView addSubview:item];
        item.tag = i;
        [item mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.backView);
            make.left.equalTo(self.mas_left).with.offset(SCREEN_WIDTH*0.25 *i +SCREEN_WIDTH*0.125-30);
            make.size.mas_offset(CGSizeMake(kWidth, 70));
        }];
    }
}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(NSString *)image {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:12]];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 20, 0);
    if (title.length>3) {
        button.titleEdgeInsets = UIEdgeInsetsMake(45, -26, 0, 0);
    }else{
        button.titleEdgeInsets = UIEdgeInsetsMake(45, -29, 0, 0);
    }
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
         [self.viewModel.farmHeadItemClickSubject sendNext:[NSString stringWithFormat:@"%ld",x.tag]];
     }];
    return button;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 5;
        _backView.layer.masksToBounds = YES;
    }
    return _backView;
}
@end
