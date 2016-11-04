//
//  YHPhotoViewController.m
//  DayDayNews
//
//  Created by 马卿 on 16/9/28.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHPhotoViewController.h"
#import "AFNetworking.h"
#import "YHPhoto.h"
#import "UIImageView+WebCache.h"
#import "HMWaterflowLayout.h"
#import "SDImageCache.h"
#import "YHCollectionViewCell.h"
//#import "MJExtension.h"
#import "NSObject+YYModel.h"
#import "YHPhotoPickerBrowserViewController.h"
#import "YHPhotoBrowserPhoto.h"
typedef  NS_ENUM (NSUInteger,LoadDataState){
    LoadDataStateInitNetWoring,
    LoadDataStateMoreData,
    LoadDataStateNewData,
};
#define photo_list_Path  [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"photoLists.json"]
@interface YHPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HMWaterflowLayoutDelegate,YHPhotoPickerBrowserViewControllerDataSource,YHPhotoPickerBrowserViewControllerDelegate>{
    int pn,rn;
    NSString *_tag1,*_tag2;
    CGFloat _itemW;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,copy)   NSMutableArray   *dataSources;
@property (nonatomic,assign) BOOL             isPullUp;
@property (nonatomic,copy) NSMutableArray *photoArray ;
@end
#define CellID @"cell"
@implementation YHPhotoViewController
#pragma mark ---lazy load
-(UICollectionView *)collectionView{
    if (!_collectionView) {
          CGRect rect = [UIScreen mainScreen].bounds;
        HMWaterflowLayout *hmLayout = [[HMWaterflowLayout alloc] init];
        _collectionView = [[UICollectionView alloc]initWithFrame:rect collectionViewLayout:hmLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册class
        [_collectionView registerNib:[UINib nibWithNibName:@"YHCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:CellID];
        //设置collectionView 边距
        //items 之间上下间距
        hmLayout.columnMargin = 5.0f;
         //items 调控items 之间左右最小边距
        hmLayout.columnMargin = 5.0f;
      CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
        /* screenW = spacing *3 + itemW *2
         itemW = (screenW -spacing *3)/2
         */
        //设置item的尺寸
        CGFloat itemW = (screenW -5.0f *3)/2.0f;
        _itemW = itemW;
        hmLayout.columnsCount = 2;
        hmLayout.sectionInset = UIEdgeInsetsMake(5.0f, 5.0f, 5.0f, 5.0f);
        hmLayout.delegate = self;
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
-(NSMutableArray *)dataSources{
    if (!_dataSources) {
        _dataSources = [[NSMutableArray alloc] init];
    }
    return _dataSources;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片";
    [self setupView];
    pn = 0,rn = 30;
    _tag1 = @"美女";
    _tag2 = @"小清新";
    [self loadDataFromDocument];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
}
- (void)loadDataFromDocument{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:photo_list_Path]) {
        NSData *data = [NSData dataWithContentsOfFile:photo_list_Path];
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        [self parseJsonData:json];
    }else{
       [self initNetWorking:LoadDataStateInitNetWoring];
    }
}
#pragma mark---获取数据
-(void)loadData{
    if (self.isPullUp) {

        [self loadMoreData];
        
    }else{
       
        [self loadNewData];
    }
}

-(void)initNetWorking:(LoadDataState)state{
    NSString *urlStr = [[NSString stringWithFormat:@"http://image.baidu.com/wisebrowse/data?tag1=%@&tag2=%@",_tag1,_tag2 ] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"pn"] = @(pn);
    parameters[@"rn"] = @(rn);
    [self HttpTool:urlStr parameters:parameters state:state];
}
-(void)HttpTool:(NSString *)urlStr parameters:(NSDictionary *)parameters state:(LoadDataState)state{
    [YHHttpTool GET:urlStr parameters:parameters success:^(id responseObject) {
        //写入数据库
        NSFileManager *fm = [NSFileManager defaultManager];
        if ([fm createFileAtPath:photo_list_Path contents:nil attributes:nil]
            ==YES) {
            NSOutputStream *outStream = [NSOutputStream outputStreamToFileAtPath:photo_list_Path append:YES];
            [outStream open];
            [NSJSONSerialization writeJSONObject:responseObject toStream:outStream options:NSJSONWritingPrettyPrinted error:nil];
        }
        //设置pn 起始位置
        switch (state) {
            case LoadDataStateInitNetWoring:
             
                break;
            case LoadDataStateMoreData:
                //关闭刷新控件
                rn += 30;
                self.isPullUp = false;
                break;
                
            case LoadDataStateNewData:
                //关闭刷新控件
                 pn += 30;
                [_refreshControl endRefreshing];
                break;
            default:
                break;
        }
        //设置数据源刷新表格数据
        [self parseJsonData:responseObject];
    }];
}
-(void)loadNewData{
    [self initNetWorking:LoadDataStateNewData];
}
-(void)loadMoreData{
    [self initNetWorking:LoadDataStateMoreData];
}
-(void)parseJsonData:(id)json{
    NSArray *imgs = json[@"imgs"];
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    for (NSDictionary *dic in imgs) {
        YHPhoto *photo = [YHPhoto modelWithDictionary:dic];
        [photos addObject:photo];
    }
    self.dataSources = photos;
    [self.collectionView reloadData];
}
#pragma mark---设置界面
-(void)setupView{
   [self.view addSubview:self.collectionView];
   [_collectionView addSubview:self.refreshControl];
}
#pragma mark---UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSources.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   YHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    return cell;
}
#pragma mark---UICollectionViewDelegate
//添加上拉无缝数据加载
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(YHCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    YHPhoto *photo = self.dataSources[indexPath.row];
    cell.photo = photo;
    NSInteger section = collectionView.numberOfSections;
    NSInteger items = [collectionView numberOfItemsInSection:section - 1]-1;
    NSInteger row = indexPath.item;
    if (section == 0 || items == 0) {
        return;
    }
    if (items == row) {
       self.isPullUp = YES;
       [self loadData];
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//  YHPhotoPickerBrowserViewController *browserVC = [[YHPhotoPickerBrowserViewController alloc] init];
//    NSMutableArray *tmp = [NSMutableArray arrayWithCapacity:0];
//    for (YHPhoto *photo in self.dataSources) {
//        YHPhotoBrowserPhoto *browserPhoto = [[YHPhotoBrowserPhoto alloc] init];
//        browserPhoto.photoURL = [NSURL URLWithString:photo.image_url];
//        [tmp addObject:browserPhoto];
//    }
//    self.photoArray = tmp;
//    tmp = nil;
//    browserVC.dataSource = self;
//    browserVC.delegate = self;
//    browserVC.currentIndexPath = indexPath;
//    [self presentViewController:browserVC animated:YES completion:nil];
}
#pragma mark---HMWaterflowLayoutDelegate
-(CGFloat)waterflowLayout:(HMWaterflowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    YHPhoto *photo = self.dataSources[indexPath.row];
    CGFloat originH = [photo.small_height floatValue];
    CGFloat originW = [photo.small_width floatValue];
    CGFloat originS = originW/originH;
    /*itemW/itemH = originS */
    CGFloat itemH = _itemW/originS;
   
    return itemH;
}
#pragma mark---YHPhotoPickerBrowserViewControllerDataSource
-(NSInteger)photoBrowser:(YHPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section{
    return self.dataSources.count;
}
-(id<YHPhotoPickerBrowserPhoto>)photoBrowser:(YHPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath{
    return self.photoArray[indexPath.row];
}

@end
