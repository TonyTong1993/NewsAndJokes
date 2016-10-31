//
//  YHVideoViewController.m
//  DayDayNews
//
//  Created by 马卿 on 16/10/11.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHVideoViewController.h"
#import "YHVideoModel.h"
#import "YHVideoNavViewCell.h"
#import "YHVideoViewCell.h"
@interface YHVideoViewController ()
@property (nonatomic,assign) int count;
@property (nonatomic,copy) NSMutableArray *dataSource;
@end

@implementation YHVideoViewController
static NSString *ID = @"YHVideoViewCell";
#pragma mark---Lazy load
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}
-(instancetype)init{
    //指定布局方式
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return [super initWithCollectionViewLayout:layout];
}
#pragma mark---view 生命周期ran
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    [self.collectionView registerClass:[YHVideoViewCell class] forCellWithReuseIdentifier:ID];
    [self.collectionView registerNib:[UINib nibWithNibName:@"YHVideoNavViewCell" bundle:nil] forCellWithReuseIdentifier:@"VideoNavViewCell"];
    [self.collectionView setBackgroundColor:[UIColor grayColor]];
    [self loadData];
    
}
#pragma mark ---private
- (void)loadData{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%d-10.html",self.count];
    NSDictionary *parameters = [NSDictionary dictionary];
    [YHHttpTool GET:urlStr parameters:parameters success:^(NSDictionary *success) {
         NSLog(@"success = %@",success);
        NSArray *videoList = success[@"videoList"];
        NSMutableArray *models = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in videoList) {
         YHVideoModel *model =  [YHVideoModel modelWithDictionary:dic];
            NSLog(@"model.title = %@",model.title);
            [models addObject:model];
        }
        self.dataSource = models;
        [self.collectionView reloadData];
    }];
}
-(UICollectionViewCell *)yh_VideoNavView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHVideoNavViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"VideoNavViewCell" forIndexPath:indexPath];
    return cell;
}
-(UICollectionViewCell *)yh_VideoView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YHVideoModel *model = self.dataSource[indexPath.row];
    YHVideoViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    
    cell.model = model;
    return cell;
}
#pragma mark-----UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger numberOfItems;
    if (section == 0) {
        numberOfItems = 1;
    }else{
        numberOfItems = self.dataSource.count;
    }
    return numberOfItems;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell;
    if (indexPath.section == 0) {
        cell = [self yh_VideoNavView:collectionView cellForItemAtIndexPath:indexPath];
    }else{
        cell  = [self yh_VideoView:collectionView cellForItemAtIndexPath:indexPath];

    }
    
    return cell;
}
#pragma mark-----UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if (indexPath.section == 0) {
        size = CGSizeMake(width, 80);
    }else{
        size = CGSizeMake(width, 240);
    }
    return size;

}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    CGFloat minimumLineSpacing;
//    if (section == 0) {
//        minimumLineSpacing = 5;
//    }else{
//        minimumLineSpacing  = 10;
//    }
    return 10;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 5, 0);
}
@end
