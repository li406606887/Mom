//
//  GroupDetailsHeadView.m
//  Nanny
//
//  Created by together on 2018/5/18.
//  Copyright © 2018年 SocketTest. All rights reserved.
//

#import "GroupDetailsHeadView.h"

#define kImageWidth SCREEN_WIDTH*0.3

@implementation GroupDetailsHeadView

- (instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (GroupDetailsViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}

- (void)setupViews {
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.backView];
    [self.backView addSubview:self.headIcon];
    [self.backView addSubview:self.name];
    [self.backView addSubview:self.time];
    [self.backView addSubview:self.content];
//    [self.backView addSubview:self.boomLine];
//    [self.backView addSubview:self.collect];
//    [self.backView addSubview:self.btnLine];
//    [self.backView addSubview:self.concern];
    
    [self addImageView];
}

- (void)layoutSubviews {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.width.offset(SCREEN_WIDTH);
    }];
    
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(15);
        make.top.equalTo(self.backView).with.offset(10);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.centerY.equalTo(self.headIcon);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.centerY.equalTo(self.name);
        make.size.mas_offset(CGSizeMake(150, 20));
    }];
    
    CGRect rect = [self.viewModel.model.content boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-50, MAXFLOAT)
                   
                                         options:NSStringDrawingUsesLineFragmentOrigin
                   
                                      attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                   
                                         context:nil];
    int contenheight = ceil(rect.size.height)+5;
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(15);
        make.top.equalTo(self.headIcon.mas_bottom).with.offset(10);
        make.right.equalTo(self.backView.mas_right).with.offset(-15);
        make.height.offset(contenheight);
    }];
    
//    [self.boomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.backView).with.offset(10);
//        make.bottom.equalTo(self.collect.mas_top);
//        make.right.equalTo(self.backView.mas_right).with.offset(-10);
//        make.height.offset(0.5);
//    }];
//
//    [self.collect mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.backView);
//        make.bottom.equalTo(self.mas_bottom);
//        make.height.offset(44);
//        make.width.equalTo(self.backView.mas_width).multipliedBy(0.5);
//    }];
//
//    [self.btnLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.backView);
//        make.centerY.equalTo(self.collect);
//        make.size.mas_offset(CGSizeMake(0.5, 30));
//    }];
//
//    [self.concern mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right);
//        make.bottom.equalTo(self.mas_bottom);
//        make.height.offset(44);
//        make.width.equalTo(self.backView.mas_width).multipliedBy(0.5);
//    }];
    [super layoutSubviews];
}

- (void)addImageView {
    int i = 0;
    for (NSDictionary *data in self.viewModel.model.imageList) {
        int line = i/3;
        int column = i%3;
        UIImageView *imageView = [[UIImageView alloc] init];
        [imageView sd_setImageWithURL:[data objectForKey:@"url"]];
        [self.backView addSubview:imageView];
        [imageView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.content.mas_bottom).with.offset(10+line*(kImageWidth+10));
            make.left.equalTo(self.backView).with.offset(column*(kImageWidth+10)+15);
            make.size.mas_offset(CGSizeMake(SCREEN_WIDTH*0.3, SCREEN_WIDTH*0.3));
        }];
        i++;
    }
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        [_backView setBackgroundColor:[UIColor whiteColor]];
    }
    return _backView;
}

-(UIImageView *)headIcon {
    if (!_headIcon) {
        _headIcon = [[UIImageView alloc] init];
        _headIcon.layer.cornerRadius = 20;
        _headIcon.layer.masksToBounds = YES;
        [_headIcon sd_setImageWithURL:[NSURL URLWithString:self.viewModel.model.headUrl] placeholderImage:[UIImage imageNamed:@"monther_default_icon"]];
    }
    return _headIcon;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.text = self.viewModel.model.nickName;
    }
    return _name;
}

-(UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:12];
        _time.text = [NSDate compareCurrentTime:self.viewModel.model.createDate];
        _time.textColor = [UIColor lightGrayColor];
        _time.textAlignment = NSTextAlignmentRight;
    }
    return _time;
}

-(UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = [UIFont systemFontOfSize:13];
        _content.numberOfLines = 0;
        _content.text = self.viewModel.model.content;
    }
    return _content;
}

- (UIView *)boomLine {
    if (!_boomLine) {
        _boomLine = [[UIView alloc] init];
        _boomLine.backgroundColor = RGB(222, 222, 222);
    }
    return _boomLine;
}

-(UIButton *)collect {
    if (!_collect) {
        _collect = [self creatBtnWithTitle:@"收藏" tag:0 selected:@"group_collect_selected" normal:@"group_collect_normal"];
        _collect.selected = [self.viewModel.model.isCollect intValue] ==1 ? YES: NO;
    }
    return _collect;
}

- (UIButton *)concern {
    if (!_concern) {
        _concern = [self creatBtnWithTitle:@"关注" tag:1 selected:@"group_focus_on_selected" normal:@"group_focus_on_normal"];
        _collect.selected = [self.viewModel.model.isAttention intValue] ==1 ? YES: NO;
    }
    return _concern;
}

- (UIView *)btnLine {
    if (!_btnLine) {
        _btnLine = [[UIView alloc] init];
        _btnLine.backgroundColor = RGB(222, 222, 222);
    }
    return _btnLine;
}

- (UIButton *)creatBtnWithTitle:(NSString *)title tag:(int)tag selected:(NSString*)selected normal:(NSString *)normal {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [button setTag:tag];
    
    @weakify(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self)
        
    }];
    return button;
}


@end
