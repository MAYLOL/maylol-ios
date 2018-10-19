//
//  MLVideoWriteManager.m
//  TBPlayer
//
//  Created by 安跃超 on 2018/9/20.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "MLVideoWriteManager.h"

//线程队列名称
static char *workConcurrentQueueName = "workConcurrentQueueName";
static char *serialQueueName = "serialQueueName";

@interface MLVideoWriteManager() {
    //读写队列
    dispatch_queue_t _workConcurrentQueue;
    dispatch_queue_t _serialQueue;
    dispatch_semaphore_t _semaphore;
}
@end

@implementation MLVideoWriteManager

+ (instancetype)manager
{
    static MLVideoWriteManager *tool;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[MLVideoWriteManager alloc] init];

    });
    return tool;
}

- (instancetype)init
{
    if(self = [super init]) {
        _workConcurrentQueue = dispatch_queue_create(workConcurrentQueueName, DISPATCH_QUEUE_CONCURRENT);
        _serialQueue = dispatch_queue_create(serialQueueName, DISPATCH_QUEUE_SERIAL);
        _semaphore = dispatch_semaphore_create(20);
    }
    return self;
}

/**
 *  读取数据
 **/
- (void)readFileAsyncAsyncWithModel:(MLVideoModel *)model completeHandle:(void (^)(NSData *data))completeHandle {
    dispatch_async(_workConcurrentQueue, ^{
        NSData *data = nil;
        //判断视频文件是否已经存储
        if ([self isExistVideoFileWithModel:model]){
            data = [[NSFileManager defaultManager] contentsAtPath:model.filePath];
        }
        if (completeHandle){
            completeHandle(data);
        }
    });
}

/**
 * 写入数据
 **/
- (void)writeFileAsyncWithModel:(MLVideoModel *)model completeHandle:(WriteCompleteHandle)completeHandle {
    model.writeState = MLWriteStateDefault;
    dispatch_async(_serialQueue, ^{
        model.writeState = MLWriteStateWaiting;
        dispatch_semaphore_wait(self->_semaphore, DISPATCH_TIME_FOREVER);
        dispatch_async(self->_workConcurrentQueue, ^{
            NSLog(@"thread-info:%@开始执行任务%@",[NSThread currentThread],model.vid);
            //判断视频文件是否已经存储
            if ([self isExistVideoFileWithModel:model]) {
                model.writeState = MLWriteStateFinish;
                if (completeHandle) {
                    completeHandle(model, nil);
                }
                if (self.delegate != nil && [self.delegate respondsToSelector:@selector(writeFinishWithModel:error:)]){
                    [self.delegate writeFinishWithModel:model error:nil];
                }
                sleep(1);
                dispatch_semaphore_signal(self->_semaphore);
                NSLog(@"thread-info:%@结束执行任务%@",[NSThread currentThread],model.vid);
                return;
            }
            //判断目录是否存在
            if ([self isExistBaseDir]) {//存在
                if ([model.resumeData writeToFile:model.filePath atomically:YES]) {
                    model.writeState = MLWriteStateFinish;
                    if (completeHandle) {
                        completeHandle(model, nil);
                    }
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(writeFinishWithModel:error:)]){
                        [self.delegate writeFinishWithModel:model error:nil];
                    }
                    NSLog(@"success 写入成功");
                } else {
                    model.writeState = MLWriteStateError;
                    if (completeHandle) {
                        completeHandle(model, [NSError errorWithDomain:@"writeError" code:-1 userInfo:nil]);
                    }
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(writeFinishWithModel:error:)]){
                        [self.delegate writeFinishWithModel:model error:[NSError errorWithDomain:@"writeError" code:-1 userInfo:nil]];
                    }
                    NSLog(@"faild 写入失败");
                }
            } else {
                if ([[NSFileManager defaultManager] createDirectoryAtPath:model.baseFilePath
                                              withIntermediateDirectories:YES
                                                               attributes:nil
                                                                    error:nil]) {
                    NSLog(@"创建成功");
                    if ([model.resumeData writeToFile:model.filePath atomically:YES]) {
                        model.writeState = MLWriteStateFinish;
                        if (completeHandle) {
                            completeHandle(model, nil);
                        }
                        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(writeFinishWithModel:error:)]){
                            [self.delegate writeFinishWithModel:model error:nil];
                        }
                        NSLog(@"success 写入成功");
                    } else {
                        model.writeState = MLWriteStateError;
                        if (completeHandle){
                            completeHandle(nil, [NSError errorWithDomain:@"writeError" code:-1 userInfo:nil]);
                        }
                        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(writeFinishWithModel:error:)]){
                            [self.delegate writeFinishWithModel:model error:[NSError errorWithDomain:@"writeError" code:-1 userInfo:nil]];
                        }
                        NSLog(@"faild 写入失败");
                    }
                } else {
                    model.writeState = MLWriteStateError;
                    if (completeHandle){
                        completeHandle(nil, [NSError errorWithDomain:@"writeError" code:-1 userInfo:nil]);
                    }
                    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(writeFinishWithModel:error:)]){
                        [self.delegate writeFinishWithModel:model error:[NSError errorWithDomain:@"writeError" code:-1 userInfo:nil]];
                    }
                    NSLog(@"创建失败");
                }
            }
            sleep(1);
            dispatch_semaphore_signal(self->_semaphore);
            NSLog(@"thread-info:%@结束执行任务%@",[NSThread currentThread],model.vid);
        });
    });
}

/**
 *  判断文件是否存在
 **/
- (BOOL)isExistVideoFileWithModel:(MLVideoModel *)model {
    //判断路径是否存在
    NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:MLBASEFILEPATHaseFilePath error:nil];
    return [array containsObject:model.fileName];
}

/**
 *  判断文件目录是否存在
 **/
- (BOOL)isExistBaseDir {
    return [[NSFileManager defaultManager] fileExistsAtPath:MLBASEFILEPATHaseFilePath];
}

/**
 *  删除所有视频
 */
- (BOOL)cleanAllVideo {
    if ([self isExistBaseDir]) {
        if ([[NSFileManager defaultManager] removeItemAtPath:MLBASEFILEPATHaseFilePath error:nil]) {
            NSLog(@"删除成功");
            return true;
        }
        return false;
    }
    return true;
}

/**
 *  删除单个视频
 */
- (BOOL)cleanWithModel:(MLVideoModel *)model {
    if ([self isExistBaseDir]) {
        if ([[NSFileManager defaultManager] removeItemAtPath:model.filePath error:nil]){
            NSLog(@"删除成功");
            return true;
        }
        return false;
    }
    return true;
}

/**
 *  获取沙盒中的所有视频
 **/
- (NSArray *)getVideoWithList {
    if([self isExistBaseDir]){
        NSArray *fileArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:MLBASEFILEPATHaseFilePath error:nil];
        return fileArr;
    }
    return [NSArray array];
}
@end
