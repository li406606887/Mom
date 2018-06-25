//
//  SubimitPhotoView.h
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"

@interface SubimitPhotoView : BaseView
@property (strong, nonatomic) UIView *backView;
@property (strong, nonatomic) UILabel *title;
@property (strong, nonatomic) UIImageView *photoImage;
@property (strong, nonatomic) UIImageView *sampleImage;
@property (copy, nonatomic) void(^clickBlock)(void);
@end
