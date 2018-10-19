//
//  PMLViewModel.h
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PMLNetRequestType.h"

@interface PMLViewModel : NSObject
/**
 登陆接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)loginRequestWithParams:(NSDictionary *)params
                   requestType:(PMLRequestType)requestType
                       success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                       failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 验证码登陆接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)vercodeLoginRequestWithParams:(NSDictionary *)params
                   requestType:(PMLRequestType)requestType
                       success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                       failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 手机号注册接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)phoneRegisterWithParams:(NSDictionary *)params
                    requestType:(PMLRequestType)requestType
                        success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 邮箱注册接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)emailRegisterWithParams:(NSDictionary *)params
                    requestType:(PMLRequestType)requestType
                        success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 根据手机修改密码接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)modifyPwdByPhoneWithParams:(NSDictionary *)params
                    requestType:(PMLRequestType)requestType
                        success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 根据邮箱修改密码接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)modifyPwdByEmailWithParams:(NSDictionary *)params
                       requestType:(PMLRequestType)requestType
                           success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                           failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 上传头像接口
 
 @param params 参数
 @param images 图像数组
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */

+ (void)uploadIconWithParams:(NSDictionary *)params
                      images:(NSArray *)images
                 requestType:(PMLRequestType)requestType
                     success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                     failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 关注接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)followUserWithParams:(NSDictionary *)params
                 requestType:(PMLRequestType)requestType
                     success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                     failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 申请注销账户
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)applyDestroyAccountWithParams:(NSDictionary *)params
                          requestType:(PMLRequestType)requestType
                              success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 首页瀑布流
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)homeWaterFlowWithParams:(NSDictionary *)params
                          requestType:(PMLRequestType)requestType
                              success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
/**
 文章点赞
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)articleLikeWithParams:(NSDictionary *)params
                    requestType:(PMLRequestType)requestType
                        success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 取消文章点赞
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)cancelArticleLikeWithParams:(NSDictionary *)params
                  requestType:(PMLRequestType)requestType
                      success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                      failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;

/**
 发送验证码接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)sendVerCodeWithParams:(NSDictionary *)params
                        requestType:(PMLRequestType)requestType
                            success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                            failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure;
@end
