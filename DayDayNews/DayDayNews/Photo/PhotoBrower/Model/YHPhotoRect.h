//
//  YHPhotoRect.h
//  YHPhotoPickerBrowerView
//
//  Created by 马卿 on 16/8/30.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface YHPhotoRect : NSObject
+ (CGRect)setMaxMinZoomScalesForCurrentBoundWithImage:(UIImage *)image;
+ (CGRect)setMaxMinZoomScalesForCurrentBoundWithImageView:(UIImageView *)imageView;
@end
