//
//  MyInformationViewController.m
//  FamilyFarm
//
//  Created by together on 2018/4/3.
//  Copyright © 2018年 Jann_Lee. All rights reserved.
//

#import "MyInformationViewController.h"
#import "MyInformationView.h"
#import "MyInformationViewModel.h"

@interface MyInformationViewController ()
@property(nonatomic,strong) MyInformationView *mainView;
@property(nonatomic,strong) MyInformationViewModel *viewModel;
@end

@implementation MyInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:@"人生阶段选择"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)addChildView {
    [self.view addSubview:self.mainView];
}

-(void)updateViewConstraints {
    [super updateViewConstraints];
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)bindViewModel {
    @weakify(self)
    [[self.viewModel.chooseHeadIconSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        [self chooseHeadImage];
    }];
    
    [[self.viewModel.saveSuccessSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}
#pragma mark - 选择头像
-(void)chooseHeadImage {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [cancle setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    
    UIAlertAction * camera = [UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseType:1];
    }];
    [camera setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    
    UIAlertAction * picture = [UIAlertAction actionWithTitle:@"相册中选取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self chooseType:0];
    }];
    [picture setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
    
    [alert addAction:cancle];
    [alert addAction:picture];
    [alert addAction:camera];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 相机代理
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    @weakify(self)
    UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
    dispatch_async(dispatch_get_main_queue(), ^{
        @strongify(self)
            self.mainView.headIcon.image = image;
    });
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
    //更新
    NSData * jpgData = UIImageJPEGRepresentation(image, 0.3f);
    loading(@"")
    [QHRequest uploadFileWithData:jpgData success:^(NSString *key) {
        hiddenHUD;
        @strongify(self)
        NSString *string = [@"http://p655k0tfe.bkt.clouddn.com/" stringByAppendingString:key];
        self.mainView.headUrl = string;
    } fail:^{
        hiddenHUD;
        showMassage(@"选取照片失败，请重新选择");
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)chooseType:(int)index {
    UIImagePickerController * pickerImage = [[UIImagePickerController alloc]init];
    pickerImage.delegate = self;
    if (index == 0) {
        pickerImage.allowsEditing = NO;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        }
    } else {
        
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            pickerImage.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
    }
    [self presentViewController:pickerImage animated:YES completion:nil];
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (MyInformationViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[MyInformationViewModel alloc] init];
    }
    return _viewModel;
}
- (MyInformationView *)mainView {
    if (!_mainView) {
        _mainView = [[MyInformationView alloc] initWithViewModel:self.viewModel];
    }
    return _mainView;
}
@end
