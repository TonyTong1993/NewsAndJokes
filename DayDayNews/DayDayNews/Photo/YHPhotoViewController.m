//
//  YHPhotoViewController.m
//  DayDayNews
//
//  Created by 马卿 on 16/9/28.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHPhotoViewController.h"

@interface YHPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@end
#define CellID @"cell"
@implementation YHPhotoViewController
#pragma mark ---lazy load
-(UICollectionView *)collectionView{
    if (!_collectionView) {
          CGRect rect = [UIScreen mainScreen].bounds;
        _collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor blackColor];
        //注册class
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
        //设置collectionView 边距
        UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)_collectionView.collectionViewLayout;
        //items 之间上下间距
        layout.minimumLineSpacing = 5.0f;
        //设置item的尺寸
        layout.itemSize = CGSizeMake(100, 100);
        //指明滑动方向
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return _collectionView;
}
-(UIRefreshControl *)refreshControl{
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
        [_refreshControl addTarget:self action:@selector(loadData) forControlEvents:UIControlEventValueChanged];
    }
    return _refreshControl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}
#pragma mark---获取数据
-(void)loadData{
    //模拟延迟加载数据
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //关闭刷新控件
        [_refreshControl endRefreshing];
        //刷新数据
        [_collectionView reloadData];
    });
}
#pragma mark---设置界面
-(void)setupView{
   [self.view addSubview:self.collectionView];
   [_collectionView addSubview:self.refreshControl];
}
#pragma mark---UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
@end
