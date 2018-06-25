//
//  YiGeSheetView.m
//  Mom
//
//  Created by wgz on 2018/6/7.
//  Copyright © 2018年 Mr.L. All rights reserved.
//


#import "YiGeSheetView.h"
#import "SheetViewCell.h"
#import "BankSheetModel.h"

static CGFloat kTransitionDuration = 0.2;
#define MyEditorWidth [UIScreen mainScreen].bounds.size.width
#define MyEditorHeight 225

@interface YiGeSheetView ()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation YiGeSheetView
-(id)init {
    self = [super init];
    if (self) {
    }
    return self;
}

-(id)initWithSortDataArray:(NSArray *)dataArray {
    self = [super init];
    if (self) {
        self.dataArray = dataArray;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BankSheetModel * model = [BankSheetModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];

    if (self.selcetBlock) {
        self.selcetBlock(model);
    }
    [self dismissAlert];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
#pragma mark - set
-(void)setSelectIndex:(NSInteger)selectIndex {
    _selectIndex = selectIndex;
    [self.tableView reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SheetViewCell * cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([SheetViewCell class])]];
    BankSheetModel * model = [BankSheetModel mj_objectWithKeyValues:self.dataArray[indexPath.row]];
    cell.contentLabel.text = model.bankName;
//    if (self.selectIndex == indexPath.row) {
//        cell.sortLabel.textColor = RGB(245, 160, 10);
//    }
    return cell;
}
-(UITableView *)tableView {
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, self.frame.size.height-90) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SheetViewCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([SheetViewCell class])]];
    }
    return _tableView;
}
-(NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSArray arrayWithObjects:@"默认排序",@"租金从低到高",@"租金从高到低",@"面积从大到小",@"面积从小到大", nil];;
    }
    return _dataArray;
}


-(void)closeBtnClick:(id)sender {
    if (self.closeBlock) {
        self.closeBlock();
    }
    [self dismissAlert];
}
#pragma mark - 继续按钮
-(void)goonAction:(UIButton *)sender {
    //代码块回掉
    if (self.goonBlock) {
        self.goonBlock();
    }
    [self dismissAlert];
}

/*
 * 展示自定义AlertView
 */
- (void)show {
    UIViewController *topVC = [self appRootViewController];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [topVC.view addSubview:self];
    
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(topVC.view);
        make.height.mas_offset(MyEditorHeight);
    }];
    
}


- (UIViewController *)appRootViewController {
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)willMoveToSuperview:(UIView *)newSuperview {
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];
    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor blackColor];
        //        self.backImageView.alpha = 0.5f;
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.backImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAlert)];
        [self.backImageView addGestureRecognizer:tap];
    }
    [topVC.view addSubview:self.backImageView];
    
    
    self.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, _tableView.rowHeight * (_dataArray.count + 1));
    self.backImageView.alpha = 0;
    //上升动画
    [UIView animateWithDuration:.25 animations:^{
        CGRect rect = self.frame;
        rect.origin.y -= _tableView.bounds.size.height;
        self.backImageView.alpha += 0.5f;
        self.frame = rect;
    }];
    
    
    [super willMoveToSuperview:newSuperview];
}

- (void)dismissAlert {
    [self remove];
}

- (void)remove {
    
    [UIView animateWithDuration:.2 animations:^{
        CGRect rect = self.frame;
        rect.origin.y += _tableView.bounds.size.height;
        self.frame = rect;
    } completion:^(BOOL finished) {
        [self.backImageView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

#pragma mark - 缩放
- (void)bounceAnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.7, 0.7);
    [UIView commitAnimations];
}

#pragma mark - 缩放
- (void)bounce2AnimationStopped {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
    [UIView commitAnimations];
}
@end
