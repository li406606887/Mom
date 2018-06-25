#import "YLWalletViewController.h"
#import "YLWalletMainView.h"
#import "YLWalletViewModel.h"
#import "UserDataModel.h"
#import "YLWithdrawViewController.h"//提现
#import "YLRechargeViewController.h"
#import "YLBalanceDetailsViewController.h"
#import "YLCardManageViewController.h"
#import "YLAccountBindingViewController.h"

@interface YLWalletViewController ()
@property (nonatomic,strong) YLWalletMainView *mainView;
@property (nonatomic,strong) YLWalletViewModel *viewModel;
@property (nonatomic,strong) UserDataModel *userModel;

@end

@implementation YLWalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"钱包";
}

-(void)bindViewModel {
    WS(weakSelf)
    
    [[self.viewModel.balanceSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id   _Nullable x) {
        UserDataModel * model = (UserDataModel *)x;
        weakSelf.userModel = model;
    }];
    
    [[self.viewModel.cellClickSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *  _Nullable x) {
        NSInteger index = [x integerValue];
        switch (index) {
//            case 0:
//            {//chongzhi
//                YLRechargeViewController * YVC = [[YLRechargeViewController alloc] init];
//                YVC.userModel = weakSelf.userModel;
//                [weakSelf.navigationController pushViewController:YVC animated:YES];
//            }
//                break;
            case 0://1
            {//mingxi
                YLBalanceDetailsViewController * BVC = [[YLBalanceDetailsViewController alloc] init];
                [weakSelf.navigationController pushViewController:BVC animated:YES];
            }
                break;
            case 1://2
            {//bangding
                YLAccountBindingViewController * BVC = [[YLAccountBindingViewController alloc] init];
                BVC.userModel = self.userModel;
                [weakSelf.navigationController pushViewController:BVC animated:YES];
            }
                break;
            case 2://3
            {//kaguanli
                YLCardManageViewController * BVC = [[YLCardManageViewController alloc] init];
                [weakSelf.navigationController pushViewController:BVC animated:YES];
            }
                break;
                
            default:
                break;
        }
    }];
    

 
}
-(void)rightClick {
    YLWithdrawViewController * WVC = [[YLWithdrawViewController alloc] init];
     WVC.userModel = self.userModel;
    [self.navigationController pushViewController:WVC animated:YES];
}


-(UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 43, 23)];
    [btn setTitle:@"提现" forState:UIControlStateNormal];
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn addTarget:self action:@selector(rightClick) forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
-(void)addChildView {
    [self.view addSubview:self.mainView];
}

-(void)updateViewConstraints {
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}
-(YLWalletViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[YLWalletViewModel alloc] init];
    }
    return _viewModel;
}
-(YLWalletMainView *)mainView {
    if (!_mainView) {
        _mainView = [[YLWalletMainView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
