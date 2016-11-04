//
//  YHJokeInfo.h
//  DayDayNews
//
//  Created by 马卿 on 16/11/4.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHJokeInfo : NSObject
/*
 title
 cover_image_uri
 video_width
 large_cover
 create_time
 medium_cover
 480p_video
 duration
 */
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSDictionary *large_cover;
@property (nonatomic, copy) NSString *coverURL;
@property (nonatomic, copy) NSString *url;
@property (nonatomic,assign) float duration;
@property (nonatomic,assign) float width;
@property (nonatomic,assign) float height;
@end
