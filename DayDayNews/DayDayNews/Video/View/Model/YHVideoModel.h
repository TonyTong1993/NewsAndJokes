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
@property (nonatomic,copy) NSString *cover;//preViewImage
//@property (nonatomic,copy) NSString *description;
@property (nonatomic,copy) NSString *m3u8Hd_url;
@property (nonatomic,copy) NSString *m3u8_url;
@property (nonatomic,copy) NSString *mp4Hd_url;
@property (nonatomic,copy) NSString *mp4_url;//播放链接
@property (nonatomic,copy) NSString *title;//标题
@property (nonatomic,assign) NSUInteger length;//时长
@property (nonatomic,copy) NSString *topicDesc;
@property (nonatomic,copy) NSString *topicName;
@property (nonatomic,assign) NSUInteger playCount;//播放次数
@property (nonatomic,copy) NSString *ptime;//发布时间
@end
