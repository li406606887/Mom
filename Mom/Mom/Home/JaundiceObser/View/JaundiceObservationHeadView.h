//
//  JaundiceObservationHeadView.h
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"
#import "SubimitPhotoView.h"

@interface JaundiceObservationHeadView : BaseView
@property (strong, nonatomic) SubimitPhotoView *headPhoto;
@property (strong, nonatomic) SubimitPhotoView *chestPhoto;
@property (strong, nonatomic) SubimitPhotoView *neckPhoto;
@property (copy, nonatomic) void (^uploadImageBlock)(int index);
@end
