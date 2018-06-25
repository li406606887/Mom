//
//  DemandDetailsHeadView.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "DemandDetailsHeadView.h"

@implementation DemandDetailsHeadView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (DemandDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self addSubview:self.backView];
    [self addSubview:self.demandInfo];
    [self addSubview:self.markInfo];
    [self addSubview:self.lineView];
    [self addSubview:self.browseDetails];
    [self addSubview:self.suspended];
    [self addSubview:self.end];
}

- (void)layoutSubviews {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(15, 0, 70, 0));
    }];
    
    [self.demandInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).with.offset(10);
        make.left.equalTo(self.backView).with.offset(15);
        make.size.mas_offset(CGSizeMake(300, 30));
    }];
    
    [self.markInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_top).with.offset(40);
        make.left.equalTo(self.demandInfo);
        make.size.mas_offset(CGSizeMake(300, 30));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.backView);
        make.top.equalTo(self.backView.mas_top).with.offset(75);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 1));
    }];
    
    [self.browseDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).with.offset(-15);
        make.bottom.equalTo(self.backView.mas_bottom).with.offset(4);
        make.size.mas_offset(CGSizeMake(300, 30));
    }];
    
    [self.suspended mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self).with.offset(-SCREEN_WIDTH*0.25);
        make.size.mas_offset(CGSizeMake(100, 40));
    }];
    
    [self.end mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self).with.offset(SCREEN_WIDTH*0.25);
        make.size.mas_offset(CGSizeMake(100, 40));
    }];
    [super layoutSubviews];
}

- (void)bindViewModel {
    @weakify(self)
    
    [self.viewModel.refreshHeadInfoSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self.suspended.hidden = NO;
        self.end.userInteractionEnabled = YES;
        if ([self.viewModel.model.status intValue] != 3) {
            [self.end setTitle:@"结束" forState:UIControlStateNormal];
        }else {
            self.end.userInteractionEnabled = NO;
            [self.end setTitle:@"已结束" forState:UIControlStateNormal];
            self.suspended.hidden = YES;
        }
        if ([self.viewModel.model.status intValue] == 2) {
            [self.suspended setTitle:@"恢复" forState:UIControlStateNormal];
        }else if([self.viewModel.model.status intValue]==1){
            [self.suspended setTitle:@"暂停" forState:UIControlStateNormal];
        }
    }];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(UILabel *)demandInfo {
    if (!_demandInfo) {
        _demandInfo = [[UILabel alloc] init];
        _demandInfo.font = [UIFont systemFontOfSize:14];
        NSString *babyNum;
        if ([self.viewModel.model.babyType intValue] == 1) {
            babyNum = @"单胞胎";
        } else if ([self.viewModel.model.babyType intValue] == 2) {
            babyNum = @"双胞胎";
        } else {
            babyNum = @"多胞胎";
        }
        _demandInfo.text = [NSString stringWithFormat:@"预产期:%@|%@天",self.viewModel.model.dueDate,self.viewModel.model.serviceDay];
    }
    return _demandInfo;
}

-(UILabel *)markInfo {
    if (!_markInfo) {
        _markInfo = [[UILabel alloc] init];
        _markInfo.font = [UIFont systemFontOfSize:14];
        _markInfo.textColor = [UIColor lightGrayColor];
        _markInfo.text = [NSString stringWithFormat:@"需求:%@人 %@岁-%@岁 %@经验",self.viewModel.model.moonAddr,self.viewModel.model.moonAgeMin,self.viewModel.model.moonAgeMax,self.viewModel.model.moonExp];
    }
    return _markInfo;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = RGB(220, 220, 220);
    }
    return _lineView;
}

-(UILabel *)browseDetails {
    if (!_browseDetails) {
        _browseDetails = [[UILabel alloc] init];
        _browseDetails.textColor = [UIColor lightGrayColor];
        _browseDetails.text = [NSString stringWithFormat:@"%@人投递 %@人浏览",self.viewModel.model.joinCount,self.viewModel.model.viewCount];
        _browseDetails.font = [UIFont systemFontOfSize:12];
        _browseDetails.textAlignment = NSTextAlignmentRight;
    }
    return _browseDetails;
}

- (UIButton *)end {
    if (!_end) {
        _end = [UIButton buttonWithType:UIButtonTypeCustom];
        _end.backgroundColor = RGB(255, 212, 60);
        [_end setTitle:@"结束" forState:UIControlStateNormal];
        if ([self.viewModel.model.status intValue] != 3) {
            [_end setTitle:@"结束" forState:UIControlStateNormal];
            _end.userInteractionEnabled = YES;
        }else {
            _end.userInteractionEnabled = NO;
            [_end setTitle:@"已结束" forState:UIControlStateNormal];
        }
        [_end setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_end.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _end.layer.masksToBounds = YES;
        _end.layer.cornerRadius = 3;
        @weakify(self)
        [[_end rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.endDemandCommand execute:nil];
        }];
    }
    return _end;
}

- (UIButton *)suspended {
    if (!_suspended) {
        _suspended = [UIButton buttonWithType:UIButtonTypeCustom];
        _suspended.backgroundColor = RGB(255, 212, 60);
        _suspended.hidden = NO;
        if ([self.viewModel.model.status intValue] == 2) {
            [_suspended setTitle:@"恢复" forState:UIControlStateNormal];
        }else if([self.viewModel.model.status intValue]==1){
            [_suspended setTitle:@"暂停" forState:UIControlStateNormal];
        }else {
            _suspended.hidden = YES;
        }
        [_suspended setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_suspended.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _suspended.layer.masksToBounds = YES;
        _suspended.layer.cornerRadius = 3;
        @weakify(self)
        [[_suspended rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            if ([self.viewModel.model.status intValue] == 2) {
                [self.viewModel.resumeDemandCommand execute:nil];
            } else {
                [self.viewModel.suspendedDemandCommand execute:nil];
            }
        }];
    }
    return _suspended;
    
}
@end
