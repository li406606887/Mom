//
//  DemandDetailsTableViewCell.m
//  Mom
//
//  Created by together on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "DemandDetailsTableViewCell.h"

@implementation DemandDetailsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DemandDetailsModel *)model {
    _model = model;
    self.stateBtn.userInteractionEnabled = YES;
    self.name.text = model.moon.nickName;
    [self.headIcon sd_setImageWithURL:[NSURL URLWithString:model.moon.headUrl] placeholderImage:[UIImage imageNamed:@"nanny_default_icon"]];
    self.mark.text = [NSString stringWithFormat:@"%@人 带过%@个宝宝",model.moon.cityName,model.moon.takecareBabies];
    NSString *stateStr;
    switch ([model.status intValue]) {
        case 12:{
            stateStr = @"邀请面试";
        }
            break;
        case 20:{
            stateStr = @"通过面试";
        }
            break;
        case 30:{
            stateStr = @"已通过";
            self.stateBtn.userInteractionEnabled = NO;
        }
            break;
        case 11:{
            stateStr = @"已拒绝";
            self.stateBtn.userInteractionEnabled = NO;
        }
            break;
        default:
            break;
    }
    [self.stateBtn setTitle:stateStr forState:UIControlStateNormal];
}
/**
 * 护理需求应聘状态: 靓妈邀请月嫂参加护理需求，等待月嫂确认（确认后状态，可能是拒绝，也可能是参加应聘）
 */
//public static final String DEMAND_APPLY_STATUS_WAIT = "10";
///**
// * 护理需求应聘状态：已应聘，待邀请
// */
//public static final String DEMAND_APPLY_STATUS_JOIN = "12";
///**
// * 护理需求应聘状态：面试邀请
// */
//public static final String DEMAND_APPLY_STATUS_INVITE = "20";
///**
// * 护理需求应聘状态：面试通过
// */
//public static final String DEMAND_APPLY_STATUS_PASS = "30";
///**
// * 护理需求应聘状态：拒绝应聘
// */
//public static final String DEMAND_APPLY_STATUS_REJECT = "11";

- (IBAction)btnClick:(id)sender {
    if (self.clickBlock) {
        self.clickBlock(_model);
    }
}
@end
