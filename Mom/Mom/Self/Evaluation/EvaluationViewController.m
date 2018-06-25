//
//  EvaluationViewController.m
//  Mom
//
//  Created by together on 2018/6/6.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "EvaluationViewController.h"
#import "EvaluationViewModel.h"

@interface EvaluationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *startOne;
@property (weak, nonatomic) IBOutlet UIButton *starttwo;
@property (weak, nonatomic) IBOutlet UIButton *startThree;
@property (weak, nonatomic) IBOutlet UIButton *startFour;
@property (weak, nonatomic) IBOutlet UIButton *startFive;
@property (weak, nonatomic) IBOutlet UIButton *label1;
@property (weak, nonatomic) IBOutlet UIButton *label2;
@property (weak, nonatomic) IBOutlet UIButton *label3;
@property (weak, nonatomic) IBOutlet UIButton *label4;
@property (weak, nonatomic) IBOutlet UIButton *label5;
@property (weak, nonatomic) IBOutlet UIButton *label6;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (strong, nonatomic) EvaluationViewModel *viewModel;
@property (assign, nonatomic) int startLevel;
@end

@implementation EvaluationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.startLevel = -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.getTagcommand execute:@{@"type":@"1"}];
    [self.viewModel.tagRefreshSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        
    }];
}

- (void)setModel:(NannyModel *)model {
    _model = model;
}

- (IBAction)startClick:(id)sender {
    UIButton *button = (UIButton *)sender;
    int index = (int)button.tag;
    switch (index) {
        case 0:{
            self.startOne.selected = YES;
            self.starttwo.selected = NO;
            self.startThree.selected = NO;
            self.startFour.selected = NO;
            self.startFive.selected = NO;
        }
            break;
        case 1:{
            self.startOne.selected = YES;
            self.starttwo.selected = YES;
            self.startThree.selected = NO;
            self.startFour.selected = NO;
            self.startFive.selected = NO;
        }
            break;
        case 2: {
            self.startOne.selected = YES;
            self.starttwo.selected = YES;
            self.startThree.selected = YES;
            self.startFour.selected = NO;
            self.startFive.selected = NO;
        }
            break;
        case 3:{
            self.startOne.selected = YES;
            self.starttwo.selected = YES;
            self.startThree.selected = YES;
            self.startFour.selected = YES;
            self.startFive.selected = NO;
        }
            break;
        case 4:{
            self.startOne.selected = YES;
            self.starttwo.selected = YES;
            self.startThree.selected = YES;
            self.startFour.selected = YES;
            self.startFive.selected = YES;
        }
            break;
            
        default:
            break;
    }
    self.startLevel = index;
}


- (IBAction)sendEcaluation:(id)sender {
    if (self.textView.text.length<1) {
        showMassage(@"请填写评论");
        return;
    }
    if (self.startLevel<0) {
        showMassage(@"选择星级");
        return;
    }
    [self.viewModel.evaluationCommand execute:@{@"context":self.textView.text,@"moonOrderId":self.model.ID,@"star":@(self.startLevel),@"tags":@""}];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (EvaluationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[EvaluationViewModel alloc] init];
    }
    return _viewModel;
}
@end
