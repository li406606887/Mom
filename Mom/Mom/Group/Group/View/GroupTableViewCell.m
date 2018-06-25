//
//  GroupTableViewCell.m
//  FamilyFarm
//
//  Created by user on 2017/10/23.
//  Copyright © 2017年 Jann_Lee. All rights reserved.
//

#import "GroupTableViewCell.h"
#import "AnswerModel.h"

@implementation GroupTableViewCell

- (void)setupViews {
    [self setBackgroundColor:[UIColor clearColor]];
    [self addSubview:self.backView];
    [self.backView addSubview:self.headIcon];
    [self.backView addSubview:self.name];
    [self.backView addSubview:self.time];
    [self.backView addSubview:self.content];
    [self.backView addSubview:self.topLine];
    [self.backView addSubview:self.answerFirst];
    [self.backView addSubview:self.answerSecond];
    [self.backView addSubview:self.lookAll];
//    [self.backView addSubview:self.boomLine];
//    [self.backView addSubview:self.collect];
//    [self.backView addSubview:self.btnLine];
//    [self.backView addSubview:self.concern];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)updateConstraints {
    [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    [self.headIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(10);
        make.top.equalTo(self.backView).with.offset(10);
        make.size.mas_offset(CGSizeMake(50, 50));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.top.equalTo(self.headIcon).with.offset(5);
        make.size.mas_offset(CGSizeMake(200, 20));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headIcon.mas_right).with.offset(10);
        make.top.equalTo(self.name.mas_bottom);
        make.size.mas_offset(CGSizeMake(150, 20));
    }];
    
    [self.content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(10);
        make.top.equalTo(self.headIcon.mas_bottom).with.offset(10);
        make.right.equalTo(self.backView.mas_right).with.offset(-10);
    }];
    
    [self.topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(10);
        make.top.equalTo(self.content.mas_bottom).with.offset(14);
        make.right.equalTo(self.backView.mas_right).with.offset(-10);
        make.height.offset(0.5);
    }];
    
    [self.answerFirst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(10);
        make.top.equalTo(self.topLine.mas_bottom).with.offset(4);
        make.right.equalTo(self.backView.mas_right).with.offset(-10);
        make.height.offset(25);
    }];
    
    [self.answerSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(10);
        make.top.equalTo(self.answerFirst.mas_bottom);
        make.right.equalTo(self.backView.mas_right).with.offset(-10);
        make.height.offset(25);
    }];
    
    [self.lookAll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).with.offset(10);
        make.bottom.equalTo(self.backView.mas_bottom).with.offset(-15);
        make.size.mas_offset(CGSizeMake(160, 24));
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
//        make.bottom.equalTo(self.backView.mas_bottom);
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
//        make.bottom.equalTo(self.backView.mas_bottom);
//        make.height.offset(44);
//        make.width.equalTo(self.backView.mas_width).multipliedBy(0.5);
//    }];
    [super updateConstraints];
}

- (void)setModel:(GroupModel *)model {
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.headUrl] placeholderImage:[UIImage imageNamed:@"monther_default_icon"]];
    self.name.text = model.nickName;
    self.time.text =[NSDate compareCurrentTime:model.createDate] ;
    self.content.text = model.content;
    if (model.commentList.count>0) {
        self.lookAll.hidden = NO;
        self.topLine.hidden = NO;
        self.answerFirst.hidden = NO;
        AnswerModel *firstAnswer = model.commentList[0];
        NSString *answer = [NSString stringWithFormat:@"%@:%@",firstAnswer.nickName,firstAnswer.content];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:answer attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
        [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, firstAnswer.nickName.length+1)];
        self.answerFirst.attributedText = attributedStr;
        if (model.commentList.count>1) {
            self.answerSecond.hidden = NO;
            AnswerModel *secondAnswer = model.commentList[1];
            NSString *answer = [NSString stringWithFormat:@"%@:%@",secondAnswer.nickName,secondAnswer.content];
            NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:answer attributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
            [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, secondAnswer.nickName.length+1)];
            self.answerSecond.attributedText = attributedStr;
        }else {
            self.answerSecond.hidden = YES;
        }
        self.lookAll.text = [NSString stringWithFormat:@"查看全部%lu条评论",(unsigned long)model.commentList.count];
    }else {
        self.answerFirst.hidden = YES;
        self.answerSecond.hidden = YES;
        self.lookAll.hidden = YES;
        self.topLine.hidden = YES;
    }
    self.concern.selected = [model.isAttention intValue] == 1 ? YES:NO;
    self.collect.selected = [model.isCollect intValue] == 1 ? YES:NO;
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
        _headIcon.layer.cornerRadius = 25;
        _headIcon.layer.masksToBounds = YES;
    }
    return _headIcon;
}

-(UILabel *)name {
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.font = [UIFont systemFontOfSize:14];
        _name.text = @"我是李辣妈";
    }
    return _name;
}

-(UILabel *)time {
    if (!_time) {
        _time = [[UILabel alloc] init];
        _time.font = [UIFont systemFontOfSize:12];
        _time.text = @"17分钟前";
        _time.textColor = [UIColor lightGrayColor];
    }
    return _time;
}

-(UILabel *)content {
    if (!_content) {
        _content = [[UILabel alloc] init];
        _content.font = [UIFont systemFontOfSize:13];
        _content.text = @"这里是圈子主要内容";
        _content.numberOfLines = 0;
    }
    return _content;
}

- (UIView *)topLine {
    if (!_topLine) {
        _topLine = [[UIView alloc] init];
        _topLine.backgroundColor = RGB(222, 222, 222);
    }
    return _topLine;
}

- (UILabel *)answerFirst {
    if (!_answerFirst) {
        _answerFirst = [[UILabel alloc] init];
        _answerFirst.font = [UIFont systemFontOfSize:13];
        _answerFirst.text = @"你可别是个傻子吧：111";
    }
    return _answerFirst;
}

- (UILabel *)answerSecond {
    if (!_answerSecond) {
        _answerSecond = [[UILabel alloc] init];
        _answerSecond.font = [UIFont systemFontOfSize:13];
        _answerSecond.text = @"你可别是个傻子吧：222";
    }
    return _answerSecond;
}

- (UILabel *)lookAll {
    if (!_lookAll) {
        _lookAll = [[UILabel alloc] init];
        _lookAll.font = [UIFont systemFontOfSize:12];
        _lookAll.text = @"查看全部200条评论";
        _lookAll.layer.masksToBounds = YES;
        _lookAll.layer.cornerRadius = 12;
        _lookAll.textAlignment = NSTextAlignmentCenter;
        [_lookAll setBackgroundColor:RGB(254, 212, 54)];
    }
    return _lookAll;
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
    }
    return _collect;
}

- (UIButton *)concern {
    if (!_concern) {
        _concern = [self creatBtnWithTitle:@"关注" tag:1 selected:@"group_focus_on_selected" normal:@"group_focus_on_normal"];
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
        if (self.btnClickBlock) {
            self.btnClickBlock((int)x.tag);
        }
    }];
    return button;
}


@end
