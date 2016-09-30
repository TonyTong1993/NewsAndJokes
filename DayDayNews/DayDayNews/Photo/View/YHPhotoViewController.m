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
#import "YHHttpTool.h"
#import "MJExtension.h"
typedef  NS_ENUM (NSUInteger,LoadDataState){
    LoadDataStateInitNetWoring,
    LoadDataStateMoreData,
    LoadDataStateNewData,
};
@interface YHPhotoViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,HMWaterflowLayoutDelegate>{
    int pn,rn;
    NSString *_tag1,*_tag2;
    CGFloat _itemW;
}
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,copy)   NSMutableArray   *dataSources;
@property (nonatomic,assign) BOOL             isPullUp;
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
    [self setupView];
    pn = 0,rn = 30;
    _tag1 = @"美女";
    _tag2 = @"小清新";
    [self initNetWorking:LoadDataStateInitNetWoring];
}
-(BOOL)prefersStatusBarHidden{
    return YES;
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
    [YHHttpTool GET:urlStr parameters:parameters success:^(NSDictionary *responseObject) {
                NSArray *imgs = responseObject[@"imgs"];
      NSMutableArray *photos = [YHPhoto mj_objectArrayWithKeyValuesArray:imgs];
        //设置pn 起始位置
        pn += 30;
        switch (state) {
            case LoadDataStateInitNetWoring:
             
                break;
            case LoadDataStateMoreData:
                 [photos reverseObjectEnumerator];
                //关闭刷新控件
                self.isPullUp = false;
                break;
            case LoadDataStateNewData:
                //关闭刷新控件
                [_refreshControl endRefreshing];
                break;
            default:
                break;
        }
         self.dataSources = photos;
         [self.collectionView reloadData];
    }];
}
-(void)loadNewData{
    [self initNetWorking:LoadDataStateNewData];
}
-(void)loadMoreData{
    [self initNetWorking:LoadDataStateMoreData];
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
@end
