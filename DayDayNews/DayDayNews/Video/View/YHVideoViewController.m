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
#import "MJRefresh.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import "Masonry.h"
#define video_list_Path  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"videoLists.json"]
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
    [self pullDown];
    [self loadDataFromDocument];
    
}
#pragma mark ---private
- (void)loadDataFromDocument{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:video_list_Path]) {
       NSData *data = [NSData dataWithContentsOfFile:video_list_Path];
       id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self parseJsonData:json];
    }else{
        [self loadData];
    }
}
- (void)loadData{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%d-10.html",self.count];
    NSDictionary *parameters = [NSDictionary dictionary];
    [YHHttpTool GET:urlStr parameters:parameters success:^(id success) {
        //写入数据库
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:video_list_Path contents:nil attributes:nil]
            ==YES) {
            NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:video_list_Path append:YES];
            [outStream open];
            [NSJSONSerialization writeJSONObject:success toStream:outStream options:NSJSONWritingPrettyPrinted error:nil];
        }
        [self parseJsonData:success];
    }];
}
- (void)parseJsonData:(id)json{
    NSArray *videoList = json[@"videoList"];
    NSMutableArray *models = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in videoList) {
        YHVideoModel *model =  [YHVideoModel modelWithDictionary:dic];
        [models addObject:model];
    }
    self.dataSource = models;
    self.count = 10;
    [self.collectionView reloadData];
    [self.collectionView.mj_header endRefreshing];
}
- (void)pullDown{
    //设置下拉刷新
    __weak typeof(self) weakSelf = self;
    MJRefreshGifHeader *headerRefresh = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        [weakSelf.collectionView.mj_header beginRefreshing];
        [weakSelf loadData];
    }];
    [self.collectionView setMj_header:headerRefresh];
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:60];
    for (int i = 1; i<= 60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%d",i]];
        [images addObject:image];
    }
    [headerRefresh setImages:images duration:1.0 forState:MJRefreshStatePulling];
    
    [headerRefresh.gifView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_top).offset(64);
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

    return 10;
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 5, 0);
}
@end
