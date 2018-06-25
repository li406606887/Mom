//
//  GroupBannerView.h
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "BaseView.h"

@interface GroupBannerView : BaseView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSMutableArray *dataArray;
- (void)addNSTimer;
- (void)removeNSTimer;
@end
