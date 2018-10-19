//
//  PMLNetWorkRequest.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLNetWorkRequest.h"
#import "AFNetworking.h"

@interface PMLNetWorkRequest ()

@end

@implementation PMLNetWorkRequest

+ (void)requestDataWithParams:(NSDictionary *)params interfaceName:(NSString *)interfaceName requestType:(PMLRequestType)requestType success:(void(^)(NSURLSessionDataTask *task, id responeObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    if (![interfaceName isKindOfClass:[NSString class]] || nil == interfaceName) {
        return;
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml",@"text/xml",@"text/html",@"application/json",@"text/plain",@"image/jpeg",@"text/html", nil];
    [manager.requestSerializer setValue:[PMLTools getUUID] forHTTPHeaderField:@"uuid"];
    manager.requestSerializer.timeoutInterval = 30;
    
    NSString *accessToken = [PMLTools readProfileString:PMLAccessToken];
    NSString *refreshToken = [PMLTools readProfileString:PMLRefreshToken];
    
    if (accessToken.length > 0) {
        [manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"access_token"];
    }
    if (refreshToken.length > 0) {
        [manager.requestSerializer setValue:refreshToken forHTTPHeaderField:@"refresh_token"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",PMLBaseUrl,interfaceName];
    
    if (PMLRequestPost == requestType) {
        [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForCheckedKey:@"code"] integerValue] == 0) {
                if (success) {
                    success(task, [responseObject objectForCheckedKey:@"data"]);
                }
            }else {
                if (failure) {
                    failure(task, nil);
                }
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task, error);
            }
        }];
    }else if (PMLRequestGet == requestType) {
        [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForCheckedKey:@"code"] integerValue] == 0) {
                if (success) {
                    success(task, [responseObject objectForCheckedKey:@"data"]);
                }
            }else {
                if (failure) {
                    failure(task, nil);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task, error);
            }
        }];
        
    }else if (PMLRequestPut == requestType) {
        [manager PUT:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForCheckedKey:@"code"] integerValue] == 0) {
                if (success) {
                    success(task, [responseObject objectForCheckedKey:@"data"]);
                }
            }else {
                if (failure) {
                    failure(task, nil);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task, error);
            }
        }];
    }else if (PMLRequestDelete == requestType) {
        [manager DELETE:url parameters:params success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if ([[responseObject objectForCheckedKey:@"code"] integerValue] == 0) {
                if (success) {
                    success(task, [responseObject objectForCheckedKey:@"data"]);
                }
            }else {
                if (failure) {
                    failure(task, nil);
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                failure(task, error);
            }
        }];
    }
}

+ (void)httpsRequestDataWithParams:(NSDictionary *)params interfaceName:(NSString *)interfaceName requestType:(PMLRequestType)requestType success:(void(^)(NSURLSessionDataTask *task, id responeObject))success failure:(void(^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    if (![interfaceName isKindOfClass:[NSString class]] || nil == interfaceName) {
        return;
    }
    //使用client.pkcs12(PMLClient.pkcs12)证书 将server.crt 修改为server.cer 后双击导入钥匙串 然后导出cer文件
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"cer"];
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    NSSet *certSet = [NSSet setWithObject:certData];
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    policy.allowInvalidCertificates = YES;
    policy.validatesDomainName = NO;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.securityPolicy = policy;
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml",@"text/xml",@"text/html",@"application/json",@"text/plain",@"image/jpeg",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 30;
    [PMLNetWorkRequest checkCredential:manager];
    
    NSString *url = [NSString stringWithFormat:@"%@%@",PMLSMSCodeURL,interfaceName];
    [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForCheckedKey:@"code"] integerValue] == 0) {
            if (success) {
                success(task, [responseObject objectForCheckedKey:@"data"]);
            }
        }else {
            if (failure) {
                failure(task, nil);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

+ (void)uploadImagesWithParams:(NSDictionary *)params interfaceName:(NSString *)interfaceName images:(NSArray *)images success:(void (^)(NSURLSessionDataTask *, id responeObject))success failure:(void (^)(NSURLSessionDataTask *, NSError *))failure {
    
    if (![interfaceName isKindOfClass:[NSString class]] || nil == interfaceName) {
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml",@"text/xml",@"text/html",@"application/json",@"text/plain",@"image/jpeg",@"text/html", nil];
    manager.requestSerializer.timeoutInterval = 30;
    
    NSString *accessToken = [PMLTools readProfileString:PMLAccessToken];
    NSString *refreshToken = [PMLTools readProfileString:PMLRefreshToken];
    if (accessToken.length > 0) {
        [manager.requestSerializer setValue:accessToken forHTTPHeaderField:@"access_token"];
    }
    if (refreshToken.length > 0) {
        [manager.requestSerializer setValue:refreshToken forHTTPHeaderField:@"refresh_token"];
    }
    
    NSString *url = [NSString stringWithFormat:@"%@%@",PMLBaseUrl,interfaceName];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSInteger count = images.count;
        for (int i = 0; i < count; i++) {
            NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmssSSS";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@%@.jpg",[PMLTools verifiCode].firstObject,str];
            UIImage *image = images[i];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
            [formData appendPartWithFileData:imageData name:@"uploadFile" fileName:fileName mimeType:@"image/jpg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSLog(@"uploadProgress is %lld,总字节 is %lld",uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, [responseObject objectForCheckedKey:@"data"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
    
}

//校验证书
+ (void)checkCredential:(AFURLSessionManager *)manager{
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
    }];
    __weak typeof(manager) weakManager = manager;
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential =nil;
        NSLog(@"authenticationMethod=%@",challenge.protectionSpace.authenticationMethod);
        //判断服务器要求客户端的接收认证挑战方式，如果是NSURLAuthenticationMethodServerTrust则表示去检验服务端证书是否合法，NSURLAuthenticationMethodClientCertificate则表示需要将客户端证书发送到服务端进行检验
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            // 基于客户端的安全策略来决定是否信任该服务器，不信任的话，也就没必要响应挑战
            if([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                // 创建挑战证书（注：挑战方式为UseCredential和PerformDefaultHandling都需要新建挑战证书）
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                // 确定挑战的方式
                if (credential) {
                    //证书挑战  设计policy,none，则跑到这里
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else { //只有双向认证才会走这里
            // client authentication
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"pkcs12"];
            NSFileManager *fileManager =[NSFileManager defaultManager];
            if(![fileManager fileExistsAtPath:p12]) {
                NSLog(@"client.p12:not exist");
            }else{
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                if ([PMLNetWorkRequest extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data]) {
                    SecCertificateRef certificate = NULL;
                    SecIdentityCopyCertificate(identity, &certificate);
                    const void*certs[] = {certificate};
                    CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
//                    credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    credential = [NSURLCredential credentialWithIdentity:identity certificates:nil persistence:NSURLCredentialPersistenceNone];
                    disposition = NSURLSessionAuthChallengeUseCredential;
                }
            }
        }
        *_credential = credential;
        return disposition;
    }];
    
}

//读取p12文件中的密码
+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    //client certificate password
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"11111111111"                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items,0);
        const void*tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void*tempTrust = NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
        
    } else {
        NSLog(@"Failedwith error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
@end
