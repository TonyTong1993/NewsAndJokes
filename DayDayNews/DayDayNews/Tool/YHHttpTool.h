//
//  YHHttpTool.h
//  DayDayNews
//
//  Created by 马卿 on 16/9/29.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface YHHttpTool : NSObject
+(void)GET:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(void (^)(id success)) success;
@end
