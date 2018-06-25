//
//  YLFillInfoCreatTableModel.h
//  Mom
//
//  Created by wgz on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLFillInfoCreatTableModel : NSObject

// 名称
@property (nonatomic, copy)NSString *title;
@property (nonatomic, copy)NSString *placeholder;
// 表单对应的字段
@property (nonatomic, copy)NSString *key;
//cell图片
@property (nonatomic,copy) NSString *imageName;

@property (nonatomic,assign) NSInteger maxLength;
//// cell的类型
//@property (nonatomic, assign)CreateTableCellType cellType;

@property (nonatomic,assign) UIKeyboardType keyboardType;

//图片cell用到
@property (nonatomic,copy) NSString *imgURL;


@property (nonatomic,copy) NSString *controllerName;
@property (nonatomic,assign) BOOL hidesBottomBarWhenPushed;

@property (nonatomic,copy) void (^operationBlock)(void);

@end
