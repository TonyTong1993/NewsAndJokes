//
//  YHPhoto.h
//  DayDayNews
//
//  Created by 马卿 on 16/9/29.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHPhoto : NSObject
//"small_url": "http://g.hiphotos.baidu.com/image/w%3D230/sign=99401ff4d300baa1ba2c40b87711b9b1/ac4bd11373f082025cd2432749fbfbedab641b61.jpg",
//"small_width": 230,
//"small_height": 346,
//"image_url": "http://g.hiphotos.baidu.com/image/pic/item/ac4bd11373f082025cd2432749fbfbedab641b61.jpg",
//"image_width": 510,
//"image_height": 769,
@property (nonatomic, copy) NSString *small_url;
@property (nonatomic, copy) NSString *small_width;
@property (nonatomic, copy) NSString *small_height;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *image_url;
@property (nonatomic, copy) NSString *image_width;
@property (nonatomic, copy) NSString *image_height;
@end
