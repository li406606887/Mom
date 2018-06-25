//
//  JaundiceObserViewController.m
//  Mom
//
//  Created by together on 2018/5/29.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "JaundiceObserViewController.h"
#import "JaundiceObservationHeadView.h"
#import "JaundiceObserViewModel.h"
#import "MyBabyViewController.h"
#import "BabyModel.h"
#import "JaundiceTableViewCell.h"
#import "JaundiceRecordViewController.h"

@interface JaundiceObserViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (strong, nonatomic) JaundiceObservationHeadView *headView;
@property (strong, nonatomic) UILabel *babyName;
@property (assign, nonatomic) int index;
@property (strong, nonatomic) JaundiceObserViewModel *viewModel;
@end

@implementation JaundiceObserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setTitle:@"黄疸检测"];
    self.table.delegate = self;
    self.table.dataSource = self;
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"JaundiceObserBabyCell"];
    [self.table registerNib:[UINib nibWithNibName:@"JaundiceTableViewCell" bundle:nil] forCellReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([JaundiceTableViewCell class])]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIBarButtonItem *)rightButton {
    UIButton* btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    @weakify(self)
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
     @strongify(self)
        if (self.viewModel.model==nil) {
            showMassage(@"请选择宝宝");
            return ;
        }
        if (self.viewModel.headUrl==nil) {
            showMassage(@"请上传额头照片");
            return ;
        }
        if (self.viewModel.chestPicUrl==nil) {
            showMassage(@"请上传胸口照片");
            return ;
        }
        if (self.viewModel.neckUrl==nil) {
            showMassage(@"请上传颈部照片");
            return ;
        }
        [self.viewModel.getCreateRecordCommand execute:@{@"babyId":self.viewModel.model.ID,@"headPicUrl":self.viewModel.headUrl,@"chestPicUrl":self.viewModel.chestPicUrl,@"neckPicUrl":self.viewModel.neckUrl}];
    }];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)bindViewModel {
    @weakify(self)
    [self.viewModel.goBackSubject subscribeNext:^(id  _Nullable x) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    [self.viewModel.getMyBabyCommand execute:nil];
    
    [self.viewModel.refreshTableSubject subscribeNext:^(id  _Nullable x) {
     @strongify(self)
        [self.table reloadData];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section ==0) {
        return 1;
    }else if(section ==1){
        return self.viewModel.dataArray.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   if (section ==1) {
        UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        titleView.backgroundColor = RGB(255, 212, 60);
        UILabel *headTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 120, 40)];
        headTitle.font = [UIFont systemFontOfSize:14];
        [headTitle setText:@"最近观测"];
        [titleView addSubview:headTitle];
        
        UILabel *lookAll = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-150, 0, 135, 40)];
        lookAll.font = [UIFont systemFontOfSize:14];
        [lookAll setText:@"所有记录 >"];
        lookAll.textAlignment = NSTextAlignmentRight;
        lookAll.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
        [[tap rac_gestureSignal] subscribeNext:^(__kindof UIGestureRecognizer * _Nullable x) {
            if (self.viewModel.model) {
                JaundiceRecordViewController *record = [[JaundiceRecordViewController alloc] init];
                record.model = self.viewModel.model;
                [self.navigationController pushViewController:record animated:YES];
            }else {
                showMassage(@"请选择宝宝");
            }
        }];
        [lookAll addGestureRecognizer:tap];
        [titleView addSubview:lookAll];
        return titleView;
    }
    return nil;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section==0) {
        return self.headView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    }else if(section == 1){
        return 40;
    }
    return 0 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section==0) {
        return 570;
    }else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 50;
    }else if(indexPath.section ==1){
        return 70;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        JaundiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithUTF8String:object_getClassName([JaundiceTableViewCell class])] forIndexPath:indexPath];
        NSInteger index = indexPath.row;
        NSLog(@"%ld",index);
        cell.model = self.viewModel.dataArray[index];
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JaundiceObserBabyCell" forIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if (self.viewModel.model) {
            cell.textLabel.text = self.viewModel.model.name;
        }else {
            cell.textLabel.text = @"选择宝宝";
        }
        self.babyName = cell.textLabel;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MyBabyViewController *mybaby = [[MyBabyViewController alloc] init];
        mybaby.state = 1;
        @weakify(self)
        mybaby.clickBlock = ^(BabyModel *model) {
         @strongify(self)
            self.viewModel.model = model;
            self.babyName.text = model.name;
            [self.viewModel.getCurrentDayCommand execute:@{@"babyId":self.viewModel.model.ID}];
        };
        [self.navigationController pushViewController:mybaby animated:YES];
    }
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
        switch (self.index) {
            case 0:
                self.headView.headPhoto.photoImage.image = image;
                break;
            case 1:
                self.headView.chestPhoto.photoImage.image = image;
                break;
            case 2:
                self.headView.neckPhoto.photoImage.image = image;
                break;
                
            default:
                break;
        }
    });
    //    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    [self dismissViewControllerAnimated:YES completion:nil];
    //更新
    NSData * jpgData = UIImageJPEGRepresentation(image, 0.3f);
    loading(@"")
    [QHRequest uploadFileWithData:jpgData success:^(NSString *key) {
        @strongify(self)
        hiddenHUD;
        NSString *string = [@"http://p655k0tfe.bkt.clouddn.com/" stringByAppendingString:key];
        switch (self.index) {
            case 0:
                self.viewModel.headUrl = string;
                break;
            case 1:
                self.viewModel.neckUrl = string;
                break;
            case 2:
                self.viewModel.chestPicUrl = string;
                break;
                
            default:
                break;
        }
    } fail:^{
        showMassage(@"选取照片失败，请重新选择");
        hiddenHUD;
        switch (self.index) {
            case 0:
                self.headView.headPhoto.photoImage.image = [UIImage imageNamed:@"group_upload_add_photo"];
                break;
            case 1:
                self.headView.chestPhoto.photoImage.image = [UIImage imageNamed:@"group_upload_add_photo"];
                break;
            case 2:
                self.headView.neckPhoto.photoImage.image = [UIImage imageNamed:@"group_upload_add_photo"];
                break;
                
            default:
                break;
        }
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

- (JaundiceObservationHeadView *)headView {
    if (!_headView) {
        _headView = [[JaundiceObservationHeadView alloc] initWithViewModel:nil];
        _headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 570);
        @weakify(self)
        _headView.uploadImageBlock = ^(int index) {
            @strongify(self)
            [self chooseHeadImage];
            self.index = index;
        };
    }
    return _headView;
}

- (JaundiceObserViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[JaundiceObserViewModel alloc] init];
    }
    return _viewModel;
}
@end
