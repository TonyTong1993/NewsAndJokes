//
//  YHPhotoPickerBrowserPhotoView.h
//  YHPhotoPickerBrowerView
//
//  Created by 马卿 on 16/8/30.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YHPhotoPickerBrowserPhotoViewDelegate;
@interface YHPhotoPickerBrowserPhotoView : UIView
@property (nonatomic, weak) id <YHPhotoPickerBrowserPhotoViewDelegate> tapDelegate;
@end
@protocol YHPhotoPickerBrowserPhotoViewDelegate <NSObject>

@optional

- (void)view:(UIView *)view singleTapDetected:(UITouch *)touch;
- (void)view:(UIView *)view doubleTapDetected:(UITouch *)touch;

@end
