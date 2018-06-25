//
//  PublishShareViewController.m
//  HNProject
//
//  Created by user on 2017/7/19.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "PublishShareViewController.h"
#import "PublishShareViewModel.h"
#import "PromptViewController.h"
#import "PublishShareView.h"
#import <Photos/Photos.h>

@interface PublishShareViewController ()
@property(nonatomic,strong) PublishShareView *publishShareView;
@property(nonatomic,strong) PublishShareViewModel *viewModel;
@end

@implementation PublishShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"提问"];
    //相册权限

     [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView{
    [self.view addSubview:self.publishShareView];
}

-(void)updateViewConstraints{
    [self.publishShareView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [super updateViewConstraints];
}

-(void)bindViewModel {
    @weakify(self)
    [self.viewModel.readPromptSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        PromptViewController *prompt = [[PromptViewController alloc] init];
        [self.navigationController pushViewController:prompt animated:YES];
    }];
    
    [self.viewModel.shareCompleteSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.refreshBlock) {
            self.refreshBlock();
        }
        [self.navigationController popViewControllerAnimated:YES];
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(PublishShareView *)publishShareView{
    if (!_publishShareView) {
        _publishShareView = [[PublishShareView alloc] initWithViewModel:self.viewModel];
    }
    return _publishShareView;
}
-(PublishShareViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[PublishShareViewModel alloc] init];
    }
    return _viewModel;
}


@end
