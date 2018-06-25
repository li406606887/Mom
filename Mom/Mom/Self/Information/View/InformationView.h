//
//  InformationView.h
//  FamilyFarm
//
//  Created by together on 2018/3/28.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "BaseView.h"
#import "InformationViewModel.h"

@interface InformationView : BaseView
@property (strong, nonatomic) InformationViewModel *viewModel;
@property (strong, nonatomic) UIImageView *tryingToConceive;//备孕
@property (strong, nonatomic) UIImageView *pregnancy;//怀孕
@property (strong, nonatomic) UIImageView *hotMom;//生了孩子变辣妈
@end
