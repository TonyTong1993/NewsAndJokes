//
//  YHPhotoPickerBrowserViewController.h
//  YHPhotoPickerBrowerView
//
//  Created by 马卿 on 16/8/30.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPhotoBrowserPhoto.h"
#import "YHPhotoPickerBrowserPhotoScrollView.h"

// maxCount的默认值，不设置maxCount的时候有效
static NSInteger const KPhotoShowMaxCount = 9;

// ScrollView 滑动的间距
static CGFloat const YHPickerColletionViewPadding = 20;

// ScrollView拉伸的比例
static CGFloat const YHPickerScrollViewMaxZoomScale = 3.0;
static CGFloat const YHPickerScrollViewMinZoomScale = 1.0;

// 进度条的宽度/高度
static NSInteger const YHPickerProgressViewW = 50;
static NSInteger const YHPickerProgressViewH = 50;

// 分页控制器的高度
static NSInteger const YHPickerPageCtrlH = 25;
@class YHPhotoPickerBrowserViewController;
@protocol YHPhotoPickerBrowserViewControllerDataSource<NSObject>
@optional
/**
 *  @auther : tony tong
 *  @brief : 有多少组
 */
- (NSInteger) numberOfSectionInPhotosInPickerBrowser:(YHPhotoPickerBrowserViewController *) pickerBrowser;
@required
/**
 *  @auther : tony tong
 *  @brief : 每个组多少个图片
 */
- (NSInteger) photoBrowser:(YHPhotoPickerBrowserViewController *)photoBrowser numberOfItemsInSection:(NSUInteger)section;
/**
 *  每个对应的IndexPath展示什么内容
 */
- (id<YHPhotoPickerBrowserPhoto>)photoBrowser:(YHPhotoPickerBrowserViewController *)pickerBrowser photoAtIndexPath:(NSIndexPath *)indexPath;

@end
@protocol YHPhotoPickerBrowserViewControllerDelegate<NSObject>
@optional
/**
 *  发送按钮和返回按钮按下时调用，向上一级控制器传递selectedAssets
 */
- (void)photoBrowserWillExit:(YHPhotoPickerBrowserViewController *)pickerBrowser;
/**
 *  滑动结束的页数
 *
 *  @param page         滑动的页数
 */
- (void)photoBrowser:(YHPhotoPickerBrowserViewController *)photoBrowser didCurrentPage:(NSUInteger)page;

/**
 *  滑动开始的页数
 *
 *  @param page         滑动的页数
 */
- (void)photoBrowser:(YHPhotoPickerBrowserViewController *)photoBrowser willCurrentPage:(NSUInteger)page;
/**
 *  点击发送执行此代理，向上一级控制器传递数据
 *
 *  @param pickerBrowser
 *  @param isOriginal     是否原图
 *  备注：这里不传selectedAssets,选择的照片每点击一次右上角的选择框就传第一次
 */
- (void)photoBrowserSendBtnTouched:(YHPhotoPickerBrowserViewController *)pickerBrowser isOriginal:(BOOL)isOriginal;
@end
@interface YHPhotoPickerBrowserViewController : UIViewController
// @require
// 数据源/代理
@property (nonatomic , weak) id<YHPhotoPickerBrowserViewControllerDataSource> dataSource;
@property (nonatomic , weak) id<YHPhotoPickerBrowserViewControllerDelegate> delegate;
@property (nonatomic, copy) NSArray *photos;

@property (nonatomic, strong) NSMutableArray *selectedAssets;
// 当前提供的组
@property (strong,nonatomic) NSIndexPath *currentIndexPath;

//@property (nonatomic) YHShowImageType showType;
// 长按保存图片会调用sheet
@property (nonatomic, strong) UIActionSheet *sheet;
// 需要增加的导航高度
@property (nonatomic, assign) CGFloat navigationHeight;

@property (nonatomic, assign) NSInteger maxCount;

@property (nonatomic, assign) BOOL isOriginal;
// 放大缩小一张图片的情况下（查看头像）
- (void)showHeadPortrait:(UIImageView *)toImageView;
// 放大缩小一张图片的情况下（查看头像）/ 缩略图是toImageView.image 原图URL
- (void)showHeadPortrait:(UIImageView *)toImageView originUrl:(NSString *)originUrl;

// 刷新数据
- (void)reloadData;

// Category Functions.
- (UIView *)getParsentView:(UIView *)view;
- (id)getParsentViewController:(UIView *)view;
@end
