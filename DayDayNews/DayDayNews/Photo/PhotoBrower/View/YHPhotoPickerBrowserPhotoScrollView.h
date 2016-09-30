//
//  YHPhotoPickerBrowserPhotoScrollView.h
//  YHPhotoPickerBrowerView
//
//  Created by 马卿 on 16/8/30.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YHPhotoBrowserPhoto.h"
#import "YHPhotoPickerBrowserPhotoScrollView.h"
#import "YHPhotoPickerBrowserPhotoView.h"
#import "YHPhotoPickerBrowserPhotoImageView.h"
typedef void(^scrollViewCallBackBlock)(id obj);
@class YHPhotoPickerBrowserPhotoScrollView;

@protocol YHPhotoPickerPhotoScrollViewDelegate <NSObject>
@optional
// 单击调用
- (void) pickerPhotoScrollViewDidSingleClick:(YHPhotoPickerBrowserPhotoScrollView *)photoScrollView;
- (void) pickerPhotoScrollViewDidLongPressed:(YHPhotoPickerBrowserPhotoScrollView *)photoScrollView;
@end

@interface YHPhotoPickerBrowserPhotoScrollView : UIScrollView <UIScrollViewDelegate, YHPhotoPickerBrowserPhotoImageViewDelegate,YHPhotoPickerBrowserPhotoViewDelegate>
@property (nonatomic,strong) YHPhotoBrowserPhoto *photo;
@property (strong,nonatomic) YHPhotoPickerBrowserPhotoImageView *photoImageView;
@property (nonatomic, weak) id <YHPhotoPickerPhotoScrollViewDelegate> photoScrollViewDelegate;

//@property (nonatomic) LGShowImageType showType;
// 单击销毁的block
@property (copy,nonatomic) scrollViewCallBackBlock callback;
- (void)setMaxMinZoomScalesForCurrentBounds;
@end
