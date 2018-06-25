//
//  GroupBannerView.m
//  Mom
//
//  Created by together on 2018/5/27.
//  Copyright © 2018年 Mr.L. All rights reserved.
//

#import "GroupBannerView.h"
#import "GroupViewModel.h"
#import "ScrollCollectionViewCell.h"
#import "BannerModel.h"

#define kCount self.imageArray.count

@interface GroupBannerView()
/***/
@property (nonatomic, strong) GroupViewModel *viewModel;
/***/
@property (nonatomic, strong) UIPageControl *pageControl;
/**计时器*/
@property (nonatomic, strong) NSMutableArray *imageArray;
/**计时器*/
@property (nonatomic, strong) NSTimer *timer;
/**当前滚动的位置*/
@property (nonatomic, assign) NSInteger currentIndex;
/**上次滚动的位置*/
@property (nonatomic, assign) NSInteger lastIndex;

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *modelArray;
@end

@implementation GroupBannerView
-(void)setupViews{
    [self addSubview:self.collectionView];
    [self addSubview:self.pageControl];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    
}

-(instancetype)initWithViewModel:(id<BaseViewModelProtocol>)viewModel {
    self.viewModel = (GroupViewModel*)viewModel;
    return [super initWithViewModel:viewModel];
}
# pragma mark 跟新约束
-(void)updateConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-16);
        make.bottom.equalTo(self.mas_bottom);
        make.size.mas_offset(CGSizeMake(60, 20));
    }];
    [super updateConstraints];
}

-(void)bindViewModel{
    @weakify(self)
    [self.viewModel.refreshBannersSubject subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        NSMutableArray *array = self.viewModel.bannersArray;
        if (array.count>0) {
            self.pageControl.numberOfPages = array.count;
            if (self.imageArray.count>0) {
                [self.imageArray removeAllObjects];
                [self.modelArray removeAllObjects];
            }
            self.imageArray = [array mutableCopy];
            self.modelArray = [array mutableCopy];
            [self.imageArray insertObject:array[array.count-1] atIndex:0];
            [self.modelArray insertObject:array[array.count-1] atIndex:0];
            [self.imageArray addObject:array[0]];
            [self.modelArray addObject:array[0]];
            [self removeNSTimer];
            [self.collectionView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:1 inSection:0];
            [self scrollToIndexPath:indexPath animated:YES];
            [self addNSTimer];
        }
        [self.collectionView reloadData];
    }];
}

# pragma mark collectionView代理事件
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ScrollCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ScrollCollectionViewCell class])] forIndexPath:indexPath];
    BannerModel *model = self.imageArray[indexPath.row];
    cell.image_url = [NSString stringWithFormat:@"%@",model.content];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    BannerModel *model = self.modelArray[indexPath.row];
    //        [self.viewModel.scrollClickSubject sendNext:model];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH-20, (SCREEN_WIDTH-20)/2.5);
}

# pragma mark scrollView代理事件
- (void)removeNSTimer {
    [self.timer invalidate];
    self.timer =nil;
}

- (void)addNSTimer {
    if (self.timer == nil) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
}

- (void)nextPage {
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
    [self scrollToIndexPath:indexPath animated:YES];
}

- (void)scrollToIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
    if (self.imageArray.count > indexPath.row) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:animated];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeNSTimer];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    if (scrollView.dragging != YES) self.userInteractionEnabled = YES;
    if (velocity.x!=0)  self.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView.dragging==NO) {
        [self addNSTimer];
        self.userInteractionEnabled = YES;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.frame.size.width;
    self.currentIndex = scrollView.contentOffset.x/width+1;
    //当滚动到最后一张图片时，继续滚向后动跳到第一张
    if (scrollView.contentOffset.x == (kCount-1)*width) {
        self.currentIndex = 1;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        return;
    }
    //当滚动到第一张图片时，继续向前滚动跳到最后一张
    if (scrollView.contentOffset.x == 0) {
        self.currentIndex = kCount-2;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.currentIndex inSection:0];
        [self scrollToIndexPath:indexPath animated:NO];
        return;
    }
    self.pageControl.currentPage = self.currentIndex-2;
}
# pragma mark 懒加载
-(UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        //设置滚动方向
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[ScrollCollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithUTF8String:object_getClassName([ScrollCollectionViewCell class])]];
    }
    return _collectionView;
}

-(UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        [_pageControl setValue:[UIImage imageNamed:@"kongxin"] forKeyPath:@"pageImage"];
        [_pageControl setValue:[UIImage imageNamed:@"shixin"] forKeyPath:@"currentPageImage"];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.numberOfPages = self.imageArray.count>0 ? self.imageArray.count:1;
    }
    return _pageControl;
}

-(NSMutableArray *)imageArray {
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

-(NSInteger)currentIndex {
    if (!_currentIndex) {
        _currentIndex = 1;
    }
    return _currentIndex;
}
-(NSMutableArray *)modelArray {
    if (!_modelArray) {
        _modelArray = [[NSMutableArray alloc] init];
    }
    return _modelArray;
}

@end
