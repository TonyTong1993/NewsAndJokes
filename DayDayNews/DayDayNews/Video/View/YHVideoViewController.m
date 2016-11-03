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
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#define video_list_Path  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"videoLists.plist"]
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
    
    //设置下拉刷新
   

    [self loadData];
    
}
#pragma mark ---private
- (void)loadData{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%d-30.html",self.count];
    NSDictionary *parameters = [NSDictionary dictionary];
    [YHHttpTool GET:urlStr parameters:parameters success:^(NSDictionary *success) {
        //写入数据库
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:video_list_Path contents:nil attributes:nil]
            ==YES) {
            [success writeToFile:video_list_Path atomically:YES];
        }
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
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}
#pragma mark-----UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
         YHVideoModel *model = self.dataSource[indexPath.row];
      AVPlayerViewController *playerVC = [[AVPlayerViewController alloc] init];
        NSURL *url = [NSURL URLWithString:model.mp4_url];
        AVPlayer *player = [AVPlayer playerWithURL:url];
        playerVC.player = player;
        [self presentViewController:playerVC animated:YES completion:^{
            [player play];
        }];
    }
    
}
#pragma mark-----UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGFloat standardRation = screen_width / screen_height;
    CGFloat video_width = screen_width;
    CGFloat video_height = 135 / standardRation;
    if (indexPath.section == 0) {
        size = CGSizeMake(screen_width, 80);
    }else{
        size = CGSizeMake(video_width, video_height + 90);
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
