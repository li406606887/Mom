//
//  MyNannyDetailsHeadView.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyNannyDetailsHeadView.h"

@implementation MyNannyDetailsHeadView
- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (MyNannyDetailsViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.headIcon];
    [self addSubview:self.name];
    [self addSubview:self.identity];
    [self addSubview:self.phone];
    [self addSubview:self.status];
    [self addSubview:self.serviceTime];
    [self addSubview:self.serviceDays];
    [self addSubview:self.payMoneyLabel];
    [self addSubview:self.money];
}

- (void)layoutSubviews {
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];

    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.top.equalTo(self.headIcon.mas_top);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];

    [self.identity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_right);
        make.top.equalTo(self.headIcon.mas_top);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];

    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.top.equalTo(self.name.mas_bottom);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];

    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self.headIcon);
        make.size.mas_offset(CGSizeMake(120, 30));
    }];

    [self.serviceTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_left);
        make.top.equalTo(self.headIcon.mas_bottom).with.offset(30);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];

    [self.serviceDays mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.centerY.equalTo(self.serviceTime);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];

    [self.payMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_left);
        make.top.equalTo(self.serviceTime.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];

    [self.money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.top.equalTo(self.serviceTime.mas_bottom).with.offset(20);
        make.size.mas_offset(CGSizeMake(120, 20));
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

- (UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.viewModel.model.moonPicUrl] placeholderImage:[UIImage imageNamed:@"nanny_default_icon"]];
    }
    return _headIcon;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.text = self.viewModel.model.moonName;
    }
    return _name;
}

- (UILabel *)identity {
    if (!_identity) {
        _identity = [[UILabel alloc] init];
        _identity.font = [UIFont systemFontOfSize:14];
        _identity.textColor = [UIColor lightGrayColor];
        _identity.text = @"月嫂";
    }
    return _identity;
}

- (UILabel *)phone {
    if (!_phone) {
        _phone = [[UILabel alloc] init];
        _phone.font = [UIFont systemFontOfSize:14];
        _phone.textColor = [UIColor lightGrayColor];
        _phone.text = self.viewModel.model.moonPhone;
    }
    return _phone;
}

- (UILabel *)status {
    if (!_status) {
        _status = [[UILabel alloc] init];
        _status.font = [UIFont systemFontOfSize:14];
        _status.textColor = [UIColor lightGrayColor];
        _status.textAlignment = NSTextAlignmentRight;
        if ([self.viewModel.model.status intValue] == 10) {
            _status.text = @"等待确认";
        } else if ([self.viewModel.model.status intValue] == 11 )  {
            _status.text = @"已拒绝";
        } else if ([self.viewModel.model.status intValue] == 70 )  {
            _status.text = @"已确认";
        } else if ([self.viewModel.model.status intValue] == 80 )  {
            _status.text = @"上户中";
        } else if ([self.viewModel.model.status intValue] == 40 )  {
            _status.text = @"已下户,未付款";
        } else if ([self.viewModel.model.status intValue] == 50 )  {
            _status.text = @"已付款,待确认";
        } else if ([self.viewModel.model.status intValue] == 60 )  {
            _status.text = @"交易完成";
        } else if ([self.viewModel.model.status intValue] == 12 )  {
            _status.text = @"已取消";
        }
    }
    return _status;
}

- (UILabel *)serviceTime {
    if (!_serviceTime) {
        _serviceTime = [[UILabel alloc] init];
        _serviceTime.font = [UIFont systemFontOfSize:14];
        _serviceTime.textColor = [UIColor lightGrayColor];
        _serviceTime.text = [NSString stringWithFormat:@"%@ - %@",self.viewModel.model.startDate,self.viewModel.model.endDate];
    }
    return _serviceTime;
}

- (UILabel *)serviceDays {
    if (!_serviceDays) {
        _serviceDays = [[UILabel alloc] init];
        _serviceDays.font = [UIFont systemFontOfSize:14];
        _serviceDays.textColor = [UIColor lightGrayColor];
        _serviceDays.textAlignment = NSTextAlignmentRight;
        _serviceDays.text = [NSString stringWithFormat:@"预计%ld天",(long)[NSDate numberOfDaysWithFromDate:self.viewModel.model.startDate toDate:self.viewModel.model.endDate]];
    }
    return _serviceDays;
}

- (UILabel *)payMoneyLabel {
    if (!_payMoneyLabel) {
        _payMoneyLabel = [[UILabel alloc] init];
        _payMoneyLabel.font = [UIFont systemFontOfSize:14];
        _payMoneyLabel.textColor = [UIColor lightGrayColor];
        _payMoneyLabel.text = @"已支付金额";
    }
    return _payMoneyLabel;
}

- (UILabel *)money {
    if (!_money) {
        _money = [[UILabel alloc] init];
        _money.font = [UIFont systemFontOfSize:14];
        _money.textColor = [UIColor lightGrayColor];
        _money.textAlignment = NSTextAlignmentRight;
        _money.text = [NSString stringWithFormat:@"%d元",[self.viewModel.model.totalMoney intValue]];
    }
    return _money;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 1.获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 2.拼接图形(路径)
    // 设置线段宽度
    CGContextSetLineWidth(ctx, 0.5);
    
    // 设置线段头尾部的样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    // 设置线段转折点的样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    /**  第1根线段  **/
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 0.9, 0.9, 0.9, 1);
    // 设置一个起点
    CGContextMoveToPoint(ctx, 15, 70);
    // 添加一条线段到(100, 100)
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH-15, 70);
    
    // 渲染一次
    CGContextStrokePath(ctx);
    
    // 3.渲染显示到view上面
    CGContextStrokePath(ctx);
}

@end
