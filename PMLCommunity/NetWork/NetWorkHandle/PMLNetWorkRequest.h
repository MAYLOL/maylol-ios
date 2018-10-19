//
//  PMLNetWorkRequest.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLNetRequestType.h"

@interface PMLNetWorkRequest : NSObject

+ (void)httpsRequestDataWithParams:(NSDictionary *)params interfaceName:(NSString *)interfaceName requestType:(PMLRequestType)requestType success:(void(^)(NSURLSessionDataTask *task, id responeObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)requestDataWithParams:(NSDictionary *)params interfaceName:(NSString *)interfaceName requestType:(PMLRequestType)requestType success:(void(^)(NSURLSessionDataTask *task, id responeObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)uploadImagesWithParams:(NSDictionary *)params interfaceName:(NSString *)interfaceName images:(NSArray *)images success:(void(^)(NSURLSessionDataTask *task, id responeObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
