//
//  YHPhotoViewController.m
//  DayDayNews
//
//  Created by 马卿 on 16/9/28.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHPhotoViewController.h"

@interface YHPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
#define CellID @"cell"
@implementation YHPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
}
#pragma mark---设置界面
-(void)setupView{
    CGRect rect = [UIScreen mainScreen].bounds;
    //指明流水布局
   UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor blackColor];
    //注册class
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:CellID];
    [self.view addSubview:collectionView];
    //设置collectionView 边距
   UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout*)collectionView.collectionViewLayout;
   layout.minimumLineSpacing = 5.0f;
    //设置item的尺寸
   layout.itemSize = CGSizeMake(100, 100);
    //指明滑动方向
   layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
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
