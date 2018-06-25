//
//  YLAccountBindingMainView.m
//  Mom
//
//  Created by wgz on 2018/5/26.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "YLAccountBindingMainView.h"
#import "YLAccountBindingViewModel.h"
#import "YLAccountBindingCell.h"
@interface YLAccountBindingMainView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) YLAccountBindingViewModel *viewModel;

@property (nonatomic,strong) NSMutableArray *bindArray;
@property (nonatomic,strong) NSMutableArray *noBindArray;
@property (nonatomic,strong) NSMutableArray *weichatOrALiArray;

@property (nonatomic,assign) BOOL hasWeichat;
@property (nonatomic,assign) BOOL hasAli;


@end

@implementation YLAccountBindingMainView

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (YLAccountBindingViewModel *)viewModel;
    return [super initWithViewModel:self.viewModel];
}
-(void)bindViewModel {
    
}

-(void)setUserModel:(UserDataModel *)userModel {
    if (userModel) {
        _userModel = userModel;
        _weichatOrALiArray  = [NSMutableArray arrayWithObjects:@"0",@"0", nil];
        _bindArray = [NSMutableArray array];
        _noBindArray =[NSMutableArray array];
        
        if (_userModel.wechatAccount.length>1) {
            [self.bindArray addObject:userModel.wechatAccount];
            [self.weichatOrALiArray replaceObjectAtIndex:0 withObject:@"1"];
            self.hasWeichat = YES;
        }else {
            [self.weichatOrALiArray replaceObjectAtIndex:0 withObject:@"0"];
            [self.noBindArray addObject:@"self_weixin"];
            self.hasWeichat = NO;
        }
        
        if (_userModel.alipayAccount.length>1) {
            [self.bindArray addObject:userModel.alipayAccount];
            [self.weichatOrALiArray replaceObjectAtIndex:1 withObject:@"1"];
            self.hasAli = YES;
        }else {
            self.hasAli = NO;
            [self.weichatOrALiArray replaceObjectAtIndex:1 withObject:@"0"];
            [self.noBindArray addObject:@"self_zhifubao"];
        }
        [self.tableView reloadData];
    }
}
-(NSMutableArray *)noBindArray {
    if (!_noBindArray) {
        _noBindArray  = [NSMutableArray array];
    }
    return _noBindArray;
}
-(NSMutableArray *)bindArray {
    if (!_bindArray) {
        _bindArray  = [NSMutableArray array];
    }
    return _bindArray;
}
-(NSMutableArray *)weichatOrALiArray {
    if (!_weichatOrALiArray) {
        _weichatOrALiArray  = [NSMutableArray arrayWithObjects:@"0",@"0", nil];
    }
    return _weichatOrALiArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.bindArray.count;
    }else return  self.noBindArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.viewModel.cellClickSubject sendNext:nil];
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    view.backgroundColor = RGB(240, 240, 240);
    UILabel * titleL = [[UILabel alloc] init];
    if (section == 0) {
        titleL.text= @"已绑定";
    }else titleL.text= @"未绑定";
    titleL.font = [UIFont systemFontOfSize:14];
    titleL.textColor = RGB(153, 153, 153);
    
    [view addSubview:titleL];
    [titleL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(15);
        make.bottom.equalTo(view).offset(-10);
    }];
    
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YLAccountBindingCell * cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([YLAccountBindingCell class])]];
    //
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
            
            if (self.hasWeichat) {
                cell.leftImgView.image = [UIImage imageNamed:@[@"self_weixin",@"self_zhifubao"][0]];
                cell.topLabel.text = @"微信";
                cell.accountLabel.text = self.bindArray[indexPath.row];
                cell.bindingBlock = ^{
                    [self.viewModel.noBindSubject sendNext:[NSString stringWithFormat:@"%d",0]];
                };
            }else {
                cell.leftImgView.image = [UIImage imageNamed:@[@"self_weixin",@"self_zhifubao"][1]];
                cell.topLabel.text = @"支付宝";
                cell.accountLabel.text = self.bindArray[indexPath.row];
                cell.bindingBlock = ^{
                    [self.viewModel.noBindSubject sendNext:[NSString stringWithFormat:@"%d",1]];
                };
            }
            
            
        }else {
            
            if (self.hasAli) {
                cell.leftImgView.image = [UIImage imageNamed:@[@"self_weixin",@"self_zhifubao"][1]];
                cell.topLabel.text = @"支付宝";
                cell.accountLabel.text = self.bindArray[indexPath.row];
                cell.bindingBlock = ^{
                    [self.viewModel.noBindSubject sendNext:[NSString stringWithFormat:@"%d",1]];
                };
               
            }else {
                
                cell.leftImgView.image = [UIImage imageNamed:@[@"self_weixin",@"self_zhifubao"][0]];
                cell.topLabel.text = @"微信";
                cell.accountLabel.text = self.bindArray[indexPath.row];
                cell.bindingBlock = ^{
                    [self.viewModel.noBindSubject sendNext:[NSString stringWithFormat:@"%d",0]];
                };
            }
            
            
        }
        cell.cellType = TableNormalCell;
        
    

    }else {
        
        if (indexPath.row == 0) {

            if (self.hasWeichat) {
                
                cell.leftImgView.image = [UIImage imageNamed:@"self_zhifubao"];
                cell.topLabel.text = @"支付宝";
                cell.bindingBlock = ^{
                    [self.viewModel.bindSubject sendNext:[NSString stringWithFormat:@"%d",1]];
                };

            }else {
                cell.leftImgView.image = [UIImage imageNamed:@"self_weixin"];
                cell.topLabel.text = @"微信";
                cell.bindingBlock = ^{
                    [self.viewModel.bindSubject sendNext:[NSString stringWithFormat:@"%d",0]];
                };
            }

        }else {

            if (self.hasAli) {
                cell.leftImgView.image = [UIImage imageNamed:@"self_weixin"];
                cell.topLabel.text = @"微信";
                cell.bindingBlock = ^{
                    [self.viewModel.bindSubject sendNext:[NSString stringWithFormat:@"%d",0]];
                };

            }else {

                cell.leftImgView.image = [UIImage imageNamed:@"self_zhifubao"];
                cell.topLabel.text = @"支付宝";
                cell.bindingBlock = ^{
                    [self.viewModel.bindSubject sendNext:[NSString stringWithFormat:@"%d",1]];
                };

                
            }

        }
        
        
//        cell.leftImgView.image = [UIImage imageNamed:self.noBindArray[indexPath.row]];
//        if ([self.noBindArray[indexPath.row] isEqualToString:@"self_weixin"]) {
//            cell.topLabel.text = @"微信";
//        }else cell.topLabel.text = @"支付宝";
//
//        cell.bindingBlock = ^{
//            [self.viewModel.bindSubject sendNext:[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
//        };

        
        cell.cellType = TableNoBindCell;
    }

    return cell;
}



-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[YLAccountBindingCell class] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([YLAccountBindingCell class])]];
        
     
        
        _tableView.backgroundColor = RGB(240, 240, 240);
    }
    return _tableView;
}

-(void)setupViews {
    [self addSubview:self.tableView];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [super updateConstraints];
}
- (YLAccountBindingViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLAccountBindingViewModel alloc] init];
    }
    return _viewModel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
