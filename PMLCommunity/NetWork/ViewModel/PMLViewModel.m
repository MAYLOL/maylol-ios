//
//  PMLViewModel.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLViewModel.h"
#import "PMLNetWorkRequest.h"
@implementation PMLViewModel
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
                       failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"users/login" requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"users/loginbytel" requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"users/registerbytel" requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"users/registerbyemail" requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                           failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"users/forgetbytel" requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                           failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"users/forgetbyemail" requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

/**
 上传头像接口
 
 @param params 参数
 @param requestType 请求类型
 @param success 成功回调
 @param failure 失败回调
 */
+ (void)uploadIconWithParams:(NSDictionary *)params
                      images:(NSArray *)images
                 requestType:(PMLRequestType)requestType
                     success:(void(^)(NSURLSessionDataTask *task, id responeObject))success
                     failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest uploadImagesWithParams:params interfaceName:@"users/uploadavata" images:images success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                     failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"FollowedUser" requestType:requestType success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                              failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"user/applydestroyaccount" requestType:requestType success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                        failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"home/waterFlow" requestType:PMLRequestPost success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                      failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"articles/like" requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                            failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest requestDataWithParams:params interfaceName:@"articles/dislike" requestType:PMLRequestPut success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

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
                      failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    [PMLNetWorkRequest httpsRequestDataWithParams:params interfaceName:@"maylol/app/api/sms/getCode" requestType:PMLRequestPost success:^(NSURLSessionDataTask *task, id responeObject) {
        if (success) {
            success(task, responeObject);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}
@end
