//
//  YHVideoModel.h
//  DayDayNews
//
//  Created by 马卿 on 16/10/31.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 group
 online_time
 type
 comments
 display_time
 */
@class YHJokeInfo;
@interface YHVideoModel : NSObject
@property (nonatomic,retain) YHJokeInfo *jokeInfo;
@property (nonatomic,copy) NSArray *comments;
@property (nonatomic,assign) NSInteger online_time;
@property (nonatomic,assign) NSInteger display_time;
@property (nonatomic,assign) NSInteger type;

@end
