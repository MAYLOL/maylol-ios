//
//  MLVideoWriteManager.h
//  TBPlayer
//
//  Created by 安跃超 on 2018/9/20.
//  Copyright © 2018年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MLVideoModel.h"

@protocol MLVideoWriteDelegate<NSObject>
- (void)writeFinishWithModel:(MLVideoModel *)model
                       error:(NSError *)error;
@end

typedef void (^WriteCompleteHandle)(MLVideoModel *model, NSError *error);

@interface MLVideoWriteManager : NSObject
@property (nonatomic,weak)id<MLVideoWriteDelegate> delegate;

+ (instancetype)manager;
//读取数据
- (void)readFileAsyncAsyncWithModel:(MLVideoModel *)model completeHandle:(void (^)(NSData *data))completeHandle;
//写入数据
- (void)writeFileAsyncWithModel:(MLVideoModel *)model completeHandle:(WriteCompleteHandle)completeHandle;
//- (void)writeWithModel:(MLVideoModel *)model successHandle:(WriteSuccessBlock)successHandle;
//判断文件是否存在
- (BOOL)isExistVideoFileWithModel:(MLVideoModel *)model;
//判断文件目录是否存在
- (BOOL)isExistBaseDir;
//删除所有视频
- (BOOL)cleanAllVideo;
//删除单个视频
- (BOOL)cleanWithModel:(MLVideoModel *)model;
//获取沙盒中的所有视频
- (NSArray *)getVideoWithList;
@end
