//
//  YHHttpTool.m
//  DayDayNews
//
//  Created by 马卿 on 16/9/29.
//  Copyright © 2016年 com.yihe. All rights reserved.
//

#import "YHHttpTool.h"
#import "AFNetworking.h"
static AFHTTPSessionManager *_mgr;
@implementation YHHttpTool
+(void)initialize{
    _mgr = [AFHTTPSessionManager manager];
    _mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [_mgr.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/json",@"text/javascript",@"application/javascript", nil]];
}
+(void)GET:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(void (^)(id responseObject)) success{
    [[_mgr GET:urlStr parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //处理成功后的responseObject
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //处理失败
        NSLog(@"%s------error=%@",__func__,[error localizedDescription]);
    }] resume];
}
@end
