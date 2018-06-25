//
//  MyNannyTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/20.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "MyNannyTableViewCell.h"

@implementation MyNannyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setupViews {
    [self.contentView addSubview:self.headIcon];
    [self.contentView addSubview:self.serviceTime];
    [self.contentView addSubview:self.state];
    [self.contentView addSubview:self.headIcon];
    [self.contentView addSubview:self.name];
    [self.contentView addSubview:self.phone];
    [self.contentView addSubview:self.endService];
    [self.contentView addSubview:self.payMoney];
    [self.contentView addSubview:self.payStatus];
}

-(void)layoutSubviews {
    [self.serviceTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(10);
        make.top.equalTo(self.contentView);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, 40));
    }];
    
    [self.state mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.serviceTime);
        make.right.equalTo(self.contentView.mas_right).with.offset(-15);
        make.size.mas_offset(CGSizeMake(120, 30));
    }];
    
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.serviceTime.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView).with.offset(10);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.top.equalTo(self.serviceTime.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH,20));
    }];
    
    [self.phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.top.equalTo(self.name.mas_bottom);
        make.size.mas_offset(CGSizeMake(120, 20));
    }];
    
    [self.payStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.top.equalTo(self.headIcon.mas_bottom).with.offset(18);
        make.size.mas_offset(CGSizeMake(120, 30));
    }];
    
    [self.payMoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.endService.mas_left).with.offset(-10);
        make.top.equalTo(self.headIcon.mas_bottom).with.offset(18);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    
    [self.endService mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-10);
        make.top.equalTo(self.headIcon.mas_bottom).with.offset(18);
        make.size.mas_offset(CGSizeMake(80, 30));
    }];
    [super layoutSubviews];
}

- (void)setModel:(NannyModel *)model {
    self.payStatus.hidden = self.payMoney.hidden = self.endService.hidden = NO;
    _model = model;
    self.serviceTime.text = [NSString stringWithFormat:@"%@ - %@ 预计%ld天",model.startDate,model.endDate,(long)[NSDate numberOfDaysWithFromDate:model.startDate toDate:model.endDate]];
    
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.moonPicUrl] placeholderImage:[UIImage imageNamed:@"nanny_default_icon"]];
    self.name.text = [NSString stringWithFormat:@"%@",model.moonName];
    self.phone.text = [NSString stringWithFormat:@"%@",model.remark];
    
    if ([model.status intValue] == 10) {
        self.payStatus.text = @"等待确认";
        self.endService.hidden = YES;
        self.payMoney.hidden = YES;
//        self.state.text = @"待确认";
    } else if ([model.status intValue] == 11 )  {
        self.payStatus.text = @"已拒绝";
        self.endService.hidden = YES;
        self.payMoney.hidden = YES;
    } else if ([model.status intValue] == 70 )  {
        self.payStatus.text = @"已确认";
        [self.endService setTitle:@"上户" forState:UIControlStateNormal];
        self.payMoney.hidden = YES;
    } else if ([model.status intValue] == 80 )  {
        self.payStatus.text = @"上户中";
        [self.endService setTitle:@"下户" forState:UIControlStateNormal];
        self.payMoney.hidden = YES;
    } else if ([model.status intValue] == 40 )  {
        self.payStatus.text = @"已下户,未付款";
        self.endService.hidden = YES;
    } else if ([model.status intValue] == 50 )  {
        self.payStatus.text = @"已付款,待确认";
        self.payMoney.hidden = YES;
        self.endService.hidden = YES;
    } else if ([model.status intValue] == 60 )  {
        self.payStatus.text = @"交易完成";
        self.payMoney.hidden = YES;
        [self.endService setTitle:@"评价" forState:UIControlStateNormal];
    } else if ([model.status intValue] == 12 )  {
        self.payStatus.text = @"已取消";
        self.payMoney.hidden = YES;
        self.endService.hidden = YES;
    }
}
//UNCONFIRM("10", "待确认"),
//REJECT("11", "拒绝邀请"),
//WAIT_SERVICE("70", "已确认，待上户"),
//IN_SERVICE("80", "上户中"),
//OUT_SERVICE("40", "下户,等待客户付款"),
//PAY_WAIT_CONFIRM("50", "已付款，待确认"),
//COMPLETE("60", "交易完成"),
//CANCEL("12", "取消订单");
-(UILabel *)serviceTime {
    if (!_serviceTime) {
        _serviceTime = [[UILabel alloc] init];
        _serviceTime.font = [UIFont systemFontOfSize:14];
        _serviceTime.text = @"从2018.01.12到2018.02.12";
    }
    return _serviceTime;
}

-(UILabel *)state {
    if (!_state) {
        _state = [[UILabel alloc] init];
        _state.font = [UIFont systemFontOfSize:14];
        _state.textAlignment = NSTextAlignmentRight;
        _state.text = @"上 户";
    }
    return _state;
}

-(UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        [_headIcon setBackgroundColor:[UIColor greenColor]];
        _headIcon.layer.cornerRadius = 20;
        _headIcon.layer.masksToBounds = YES;
    }
    return _headIcon;
}

- (UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.text = @"李辣妈";
    }
    return _name;
}

- (UILabel *)phone {
    if (!_phone) {
        _phone = [[UILabel alloc] init];
        _phone.font = [UIFont systemFontOfSize:14];
        _phone.textColor = RGB(202, 202, 202);
        _phone.text = @"12345678901";
    }
    return _phone;
}

-(UIButton *)endService {
    if (!_endService) {
        _endService = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endService setTitle:@"下 户" forState:UIControlStateNormal];
        [_endService setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_endService setBackgroundColor:RGB(254, 212, 56)];
        [_endService.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _endService.layer.masksToBounds = YES;
        _endService.layer.cornerRadius = 15;
        @weakify(self)
        [[_endService rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
         @strongify(self)
            if (self.endClickBlock) {
                self.endClickBlock(self.model);
            }
        }];
    }
    return _endService;
}

-(UIButton *)payMoney {
    if (!_payMoney) {
        _payMoney = [UIButton buttonWithType:UIButtonTypeCustom];
        [_payMoney setTitle:@"付款" forState:UIControlStateNormal];
        [_payMoney setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_payMoney setBackgroundColor:RGB(222, 222, 222)];
        [_payMoney.titleLabel setFont:[UIFont systemFontOfSize:14]];
        _payMoney.layer.masksToBounds = YES;
        _payMoney.layer.cornerRadius = 15;
        @weakify(self)
        [[_payMoney rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            if (self.payClickBlock) {
                self.payClickBlock(self.model);
            }
        }];
    }
    return _payMoney;
}

- (UILabel *)payStatus {
    if (!_payStatus) {
        _payStatus = [[UILabel alloc] init];
        _payStatus.font = [UIFont systemFontOfSize:13];
        _payStatus.text = @"未付款";
    }
    return _payStatus;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    // 1.获得图形上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 2.拼接图形(路径)
    // 设置线段宽度
    CGContextSetLineWidth(ctx, 1);
    
    // 设置线段头尾部的样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    // 设置线段转折点的样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    /**  第1根线段  **/
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 0.93, 0.93, 0.93, 1);
    // 设置一个起点
    CGContextMoveToPoint(ctx, 15, 40);
    // 添加一条线段到(100, 100)
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH-15, 40);
    // 渲染一次
    CGContextStrokePath(ctx);
    /**  第2根线段  **/
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 0.95, 0.95, 0.95, 1);
    // 设置一个起点
    CGContextMoveToPoint(ctx, 15, 100);
    // 添加一条线段到(150, 40)
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH-15, 100);
    // 3.渲染显示到view上面
    CGContextStrokePath(ctx);
    
    CGContextSetLineWidth(ctx, 10);
    
    // 设置线段头尾部的样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    // 设置线段转折点的样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    /**  第1根线段  **/
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 0.95, 0.95, 0.95, 1);
    // 设置一个起点
    CGContextMoveToPoint(ctx, 0, 155);
    // 添加一条线段到(100, 100)
    CGContextAddLineToPoint(ctx, SCREEN_WIDTH, 155);
    // 渲染一次
    CGContextStrokePath(ctx);
}
@end
