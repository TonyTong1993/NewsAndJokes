//
//  YHPhotoPickerBrowserPhotoImageView.h
//  YHPhotoPickerBrowerView
//
//  Created by 马卿 on 16/8/30.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHPhotoPickerBrowserPhotoImageViewDelegate;
@interface YHPhotoPickerBrowserPhotoImageView : UIImageView
@property (nonatomic, weak) id <YHPhotoPickerBrowserPhotoImageViewDelegate> tapDelegate;
@property (assign,nonatomic) CGFloat progress;

- (void)addScaleBigTap;
- (void)removeScaleBigTap;
@end

@protocol YHPhotoPickerBrowserPhotoImageViewDelegate <NSObject>

@optional
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
@end
