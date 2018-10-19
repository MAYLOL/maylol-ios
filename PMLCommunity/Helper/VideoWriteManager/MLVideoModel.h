//
//  MLVideoModel.h
//  TBPlayer
//
//  Created by 安跃超 on 2018/9/20.
//  Copyright © 2018年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"

#define MLVideoDirctoryEnvKey @"MLVIDEODIRCTORY"
#define MLBASEFILEPATHaseFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:MLVideoDirctoryEnvKey]

typedef NS_ENUM(NSInteger, MLWriteState) {
    MLWriteStateDefault = 0,  // 默认
    MLWriteStateWritinging,  // 正在写入
    MLWriteStateWaiting,      // 等待
    MLWriteStateFinish,       // 完成
    MLWriteStateError,        // 错误
};

@interface MLVideoModel : NSObject
@property (nonatomic, copy) NSString *base64DataStr;        // base64Str
@property (nonatomic, copy) NSString *vid;                  // id标识
@property (nonatomic, copy) NSString *createTime;           // 创建时间
@property (nonatomic, assign) MLWriteState writeState;      // 写入状态

@property (nonatomic, readonly, copy) NSURL *localUrl;                // 路径
@property (nonatomic, readonly, copy) NSString *filePath;             // 下载完成路径
@property (nonatomic, readonly, copy) NSString *fileName;             // 文件名
@property (nonatomic, readonly, copy) NSData *resumeData;             // 数据
//@property (nonatomic, readonly, copy) NSString *dataTenEnd;         // 字节
@property (nonatomic, readonly, copy) NSString *baseFilePath;         // 目标目录
@property (nonatomic, readonly, copy) UIImage *preViewImage;          // 视频第一帧图像
@property (nonatomic, readonly, copy) UIImage *base64Image;          // base64图像


- (instancetype)initWithBase64DataStr:(NSString *)base64DataStr
                                  vid:(NSString *)vid
                           createTime:(NSString *)createTime;

+ (NSString *)getTxt;
@end
