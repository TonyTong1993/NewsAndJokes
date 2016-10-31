//
//  YHVideoModel.h
//  DayDayNews
//
//  Created by 马卿 on 16/10/31.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 cover
 description
 length
 m3u8Hd_url
 m3u8_url
 mp4Hd_url
 mp4_url
 playCount int
 playersize int
 ptime
 title
 topicDesc
 topicImg
 topicName
 topicSid
 videoTopic dictionary{
 
 }
 videosource
 */
@interface YHVideoModel : NSObject
@property (nonatomic,copy) NSString *cover;
//@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *m3u8Hd_url;
@property (nonatomic,copy) NSString *m3u8_url;
@property (nonatomic,copy) NSString *mp4Hd_url;
@property (nonatomic,copy) NSString *mp4_url;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *topicDesc;
@property (nonatomic,copy) NSString *topicName;
@end
