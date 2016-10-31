//
//  YHVideoViewController.m
//  DayDayNews
//
//  Created by 马卿 on 16/10/11.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHVideoViewController.h"
#import "YHVideoModel.h"
@interface YHVideoViewController ()
@property (nonatomic,assign) int count;
@end

@implementation YHVideoViewController
static NSString *ID = @"UICollectionViewCell";
-(instancetype)init{
    //指定布局方式
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    return [super initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"视频";
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:ID];
    [self loadData];
    
}
- (void)loadData{
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/video/home/%d-10.html",self.count];
    NSDictionary *parameters = [NSDictionary dictionary];
    [YHHttpTool GET:urlStr parameters:parameters success:^(NSDictionary *success) {
        NSLog(@"success = %@",success);
        NSArray *videoList = success[@"videoList"];
        NSMutableArray *models = [[NSMutableArray alloc] init];
        for (NSDictionary *dic in videoList) {
         YHVideoModel *model =  [YHVideoModel modelWithDictionary:dic];
            [models addObject:model];
        }
       
    }];
}
#pragma mark-----UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 10;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
#pragma mark-----UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGSize size;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    if (indexPath.row == 0) {
        size = CGSizeMake(width, 80);
    }else{
        size = CGSizeMake(width, 150);
    }
    return size;

}


@end
