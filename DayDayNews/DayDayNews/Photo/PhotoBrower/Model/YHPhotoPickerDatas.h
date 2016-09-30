//
//  YHPhotoPickerDatas.h
//  YHPhotoPickerBrowerView
//
//  Created by 马卿 on 16/8/30.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <Foundation/Foundation.h>
@class YHPhotoPickerGroup;
// 回调
typedef void(^groupCallBackBlock)(id obj);
@interface YHPhotoPickerDatas : NSObject
/**
 *  获取所有组
 */
+ (instancetype) defaultPicker;

/**
 * 获取所有组对应的图片
 */
- (void) getAllGroupWithPhotos : (groupCallBackBlock ) callBack;

/**
 * 获取所有组对应的Videos
 */
- (void) getAllGroupWithVideos : (groupCallBackBlock ) callBack;

/**
 *  传入一个组获取组里面的Asset
 */
- (void) getGroupPhotosWithGroup : (YHPhotoPickerGroup *) pickerGroup finished : (groupCallBackBlock ) callBack;

/**
 *  传入一个AssetsURL来获取UIImage
 */
- (void) getAssetsPhotoWithURLs:(NSURL *) url callBack:(groupCallBackBlock ) callBack;

@end
