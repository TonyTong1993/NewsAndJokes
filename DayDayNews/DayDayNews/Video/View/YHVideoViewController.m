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
#import "YHJokeInfo.h"
#define video_list_Path  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"videoLists.plist"]
@interface YHVideoViewController ()
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
    /*
     http://ic.snssdk.com/neihan/stream/mix/v1/?content_type=-104&iid=6133906033&os_version=9.3&os_api=18&app_name=joke_essay&channel=App%20Store&device_platform=iphone&idfa=697404CB-5F6C-4647-9360-1E7A45C95A3E&live_sdk_version=130&vid=E73FF3FB-687F-427E-A6AC-2CC6D9504BE3&openudid=a3884542ba0457088bd1bdb63df8e202d6ec24c9&device_type=iPhone8,1&version_code=5.6.0&ac=WIFI&screen_width=750&device_id=34132309956&aid=7&city=%E6%B9%96%E5%8C%97%E7%9C%81&content_type=-104&count=30&essence=1&latitude=30.53599676681255&longitude=114.3259168610388&message_cursor=0&min_time=0&mpic=1
     http://ic.snssdk.com/neihan/stream/mix/v1/
     */

    //NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%d-10.html",self.count];
    NSString *urlStr = [NSString stringWithFormat:@"http://ic.snssdk.com/neihan/stream/mix/v1"];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"content_type"] = @"-104";
    parameters[@"iid"] = @"6133906033";
    parameters[@"os_version"] = @"9.3";
    parameters[@"os_api"] = @"18";
    parameters[@"app_name"] = @"joke_essay";
    parameters[@"channel"] = @"App%20Store";
    parameters[@"device_platform"] = @"iphone";
    parameters[@"idfa"] = @"697404CB-5F6C-4647-9360-1E7A45C95A3E";
    parameters[@"live_sdk_version"] = @"130";
    parameters[@"vid"] = @"E73FF3FB-687F-427E-A6AC-2CC6D9504BE3";
    parameters[@"openudid"] = @"a3884542ba0457088bd1bdb63df8e202d6ec24c9";
    parameters[@"device_type"] = @"iPhone8,1";
    parameters[@"version_code"] = @"5.6.0";
    parameters[@"ac"] = @"WIFI";
    parameters[@"screen_width"] = @"750";
    parameters[@"device_id"] = @"34132309956";
    parameters[@"aid"] = @"7";
    parameters[@"city"] = @"%E6%B9%96%E5%8C%97%E7%9C%81";
    parameters[@"content_type"] = @"-104";
    parameters[@"count"] = @"30";
    parameters[@"essence"] = @"1";
    parameters[@"latitude"] = @"30.53599676681255";
    parameters[@"longitude"] = @"114.3259168610388";
    parameters[@"message_cursor"] = @"0";
    parameters[@"min_time"] = @"0";
    parameters[@"mpic"] = @"1";
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
    NSArray *videoList = json[@"data"][@"data"];
    NSMutableArray *models = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in videoList) {
        if (!dic[@"group"]) continue;
        NSDictionary *group = dic[@"group"];
      YHJokeInfo *jokeInfo =  [YHJokeInfo modelWithDictionary:group];
        NSArray *medium_cover = group[@"medium_cover"][@"url_list"];
        jokeInfo.coverURL = [medium_cover lastObject][@"url"];
        NSDictionary *videoInfo = group[@"480p_video"];
        NSArray *url_list = videoInfo[@"url_list"] ;
        jokeInfo.url = [url_list lastObject][@"url"];
        jokeInfo.width    = [videoInfo[@"width"] integerValue];
        jokeInfo.height    = [videoInfo[@"height"] integerValue];
        YHVideoModel *model = [[YHVideoModel alloc] init];
        model.jokeInfo = jokeInfo;
        model.type = [dic[@"type"] integerValue];
        model.online_time = [dic[@"online_time"] integerValue];
        model.display_time = [dic[@"type"] integerValue];
        model.comments     = dic[@"comments"];
       [models addObject:model];
    }
    self.dataSource = models;
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
        NSURL *url = [NSURL URLWithString:model.jokeInfo.url];
        AVPlayer *player = [AVPlayer playerWithURL:url];
        playerVC.player = player;
        [self presentViewController:playerVC animated:YES completion:^{
            [player play];
        }];
    }
    
}
#pragma mark-----UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    CGFloat screen_width = [UIScreen mainScreen].bounds.size.width;
    CGFloat screen_height = [UIScreen mainScreen].bounds.size.height;
    CGSize size = CGSizeMake(screen_width, 80);
    if (indexPath.section == 0) {
        size = CGSizeMake(screen_width, 80);
    }else{
        YHVideoModel *model = self.dataSource[indexPath.row];
        CGFloat standardRation = screen_width / screen_height;
        CGFloat ration = model.jokeInfo.width/model.jokeInfo.height;
        CGFloat video_width = screen_width;
        CGFloat video_height = screen_width / ration;
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
