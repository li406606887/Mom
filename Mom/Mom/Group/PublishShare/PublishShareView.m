//
//  PublishShareView.m
//  HNProject
//
//  Created by user on 2017/7/19.
//  Copyright © 2017年 OnePiece. All rights reserved.
//

#import "PublishShareView.h"
#import "PublishShareViewModel.h"
#import "PhotosView.h"
#import "PhotoModel.h"

@interface PublishShareView ()
@property(nonatomic,strong) PublishShareViewModel *viewModel;
@property(nonatomic,strong) PhotosView *photoView;
@property(nonatomic,strong) UIView *backView;
@property(nonatomic,strong) UILabel *placeHolderLabel;
@property(nonatomic,strong) UITextView *contentView;
@property(nonatomic,strong) UIButton *prompt;
@property(nonatomic,strong) NSMutableArray *keyArray;
@property (strong, nonatomic) UIButton *sendButton;
@end

@implementation PublishShareView
-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel{
    self.viewModel = (PublishShareViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}
-(void)setupViews{
    [self addSubview:self.backView];
    [self addSubview:self.photoView];
    [self.backView addSubview:self.contentView];
    [self.contentView addSubview:self.placeHolderLabel];
    [self addSubview:self.prompt];
    [self addSubview:self.sendButton];
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}
-(void)updateConstraints{
    [super updateConstraints];
   
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(10);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 150));
    }];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(8, 8, 8, 8));
    }];
    
    [self.photoView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_bottom);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, SCREEN_WIDTH*0.3+20));
    }];
    
    
    [self.placeHolderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).with.offset(6);
        make.top.equalTo(self.contentView).with.offset(6);
        make.size.mas_offset(CGSizeMake(100, 20));
    }];
    [self.prompt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(self.photoView.mas_bottom).with.offset(10);
        make.size.mas_offset(CGSizeMake(140, 30));
    }];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.prompt.mas_bottom).with.offset(10);
        make.centerX.equalTo(self);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH-30, 40));
    }];
}

-(void)bindViewModel{
    @weakify(self)
    [[self.viewModel.publishShareSubject takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        if (self.viewModel.shareContent.length < 1) {
            showMassage(@"请输入分享内容");
            return ;
        }
        if (self.photoView.selectArray.count>0) {
            loading(@"正在上传")
            NSArray *imageArray = self.photoView.selectArray;
            for (int i = 0; i<imageArray.count; i++) {
                PhotoModel *image = imageArray[i];
                NSData *data =UIImageJPEGRepresentation(image.image, 0.5);
                [QHRequest uploadFileWithData:data success:^(NSString *key) {
                    [self.keyArray addObject:@{@"url":[NSString stringWithFormat:@"http://p655k0tfe.bkt.clouddn.com/%@",key],@"name":@""}];
                    if (self.keyArray.count == imageArray.count) {
                        hiddenHUD;
                        [self sendSharesContent];
                    }
                } fail:^{
                    hiddenHUD;
                    showMassage(@"图片上传失败");
                }];
            }
        }else{
            [self sendSharesContent];
        }
        
    }];
}

-(void)sendSharesContent{
    NSString *fileString = @"";
    if (self.keyArray.count>0) {
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.keyArray options:NSJSONWritingPrettyPrinted error:nil];
        fileString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableDictionary *param = [[NSMutableDictionary alloc] init];
    [param setObject:self.viewModel.shareContent forKey:@"content"];
    [param setObject:fileString forKey:@"images"];
    [self.viewModel.publishShareCommand execute:param];
    [self.keyArray removeAllObjects];
}
#pragma mark - 上传七牛
-(void)uploadHeadImgViewWithImage:(UIImage *)image andQiniuToken:(NSString *)token {
    //上传7niu
    QNUploadManager *upManager = [[QNUploadManager alloc]init];
    NSData * jpgData = UIImageJPEGRepresentation(image, 0.3f);
    NSString * key = [NSUUID UUID].UUIDString;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    @weakify(self)
    [upManager putData:jpgData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        @strongify(self)
        if (info.statusCode == 200) {
            [self.keyArray addObject:key];
            dispatch_semaphore_signal(semaphore);
        }
    } option:nil];
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

}
- (NSString *)arc4randomForKey {
    NSString *string = [[NSString alloc]init];
    for (int i = 0; i < 32; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            string = [string stringByAppendingString:tempString];
        }else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            string = [string stringByAppendingString:tempString];
        }
    }
    return string;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(PhotosView *)photoView {
    if (!_photoView) {
        _photoView = [[PhotosView alloc] initWithViewModel:self.viewModel];
        _photoView.backgroundColor = [UIColor whiteColor];
    }
    return _photoView;
}


-(UITextView *)contentView {
    if (!_contentView) {
        _contentView = [[UITextView alloc] init];
        @weakify(self)
        [[_contentView rac_textSignal] subscribeNext:^(NSString * _Nullable x) {
            @strongify(self)
            if (_contentView.text.length<1) {
                self.placeHolderLabel.alpha = 1;
            }else{
                self.placeHolderLabel.alpha = 0;
            }
            self.viewModel.shareContent = x;
        }];
    }
    return _contentView;
}

-(UILabel *)placeHolderLabel {
    if (!_placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] init];
        _placeHolderLabel.text = @"编辑内容";
        _placeHolderLabel.textColor = RGB(200, 200, 200);
        _placeHolderLabel.font = [UIFont systemFontOfSize:14];
    }
    return _placeHolderLabel;
}

-(UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor whiteColor];
    }
    return _backView;
}

-(NSMutableArray *)keyArray {
    if (!_keyArray) {
        _keyArray = [[NSMutableArray alloc] init];
    }
    return _keyArray;
}

-(UIButton *)prompt {
    if (!_prompt) {
        _prompt = [[UIButton alloc] init];
        [_prompt setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_prompt setTitle:@"《发表内容注意事项》" forState:UIControlStateNormal];
        [_prompt.titleLabel setFont:[UIFont systemFontOfSize:12]];
        @weakify(self)
        [[_prompt rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [self.viewModel.readPromptSubject sendNext:nil];
        }];
    }
    return _prompt;
}

- (UIButton *)sendButton {
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setTitle:@"发布" forState:UIControlStateNormal];
        [_sendButton.titleLabel setTextAlignment:NSTextAlignmentRight];
        [_sendButton.titleLabel setFont:[UIFont systemFontOfSize:13]];
        [_sendButton setBackgroundColor:RGB(255, 212, 60)];
        [_sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [[_sendButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            [self.viewModel.publishShareSubject sendNext:nil];
        }];//设置按钮的点击事件
        _sendButton.layer.cornerRadius = 5;
        _sendButton.layer.masksToBounds = YES;
    }
    return _sendButton;
}
@end
