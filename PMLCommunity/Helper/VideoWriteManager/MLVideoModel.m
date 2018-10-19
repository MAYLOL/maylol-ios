//
//  MLVideoModel.m
//  TBPlayer
//
//  Created by 安跃超 on 2018/9/20.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "MLVideoModel.h"
#import <AVFoundation/AVAsset.h>
#import <AVFoundation/AVAssetImageGenerator.h>
#import <AVFoundation/AVTime.h>

@interface MLVideoModel()
@property (nonatomic, readwrite, copy) NSURL *localUrl;                // 路径
@property (nonatomic, readwrite, copy) NSString *filePath;             // 下载完成路径
@property (nonatomic, readwrite, copy) NSString *fileName;             // 文件名
@property (nonatomic, readwrite, copy) NSData *resumeData;             // 数据
//@property (nonatomic, readwrite, copy) NSString *dataTenEnd;         // 字节
@property (nonatomic, readwrite, copy) NSString *baseFilePath;         // 目标目录
@property (nonatomic, readwrite, copy) UIImage *preViewImage;          // 视频第一帧图像
@property (nonatomic, readwrite, copy) UIImage *base64Image;          // base64图像
@end
@implementation MLVideoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"base64DataStr":@"data"};
}

//- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
//    if ([property.name isEqualToString:@"base64DataStr"]) {
//        return [MLVideoModel getTxt];
//    }
//    return self;
//}
- (NSURL *)localUrl {
    if (!_localUrl){
        NSURL *url = [NSURL fileURLWithPath:self.filePath];
        _localUrl = url;
    }
    return _localUrl;
}
//获取文件路径
- (NSString *)filePath
{
    if (!_filePath) {
        NSString *filePath = [[self baseFilePath] stringByAppendingString:[NSString stringWithFormat:@"/%@",self.fileName]];
        _filePath = filePath;
    }
    return _filePath;
}

- (NSString *)fileName {
    if (!_fileName){
        NSString *fileName = [NSString stringWithFormat:@"%@%@.mp4",_vid,_createTime];
        _fileName = fileName;
    }
    return _fileName;
}

- (NSData *)resumeData {
    // 加载本地base64Data
    if (!_resumeData){
        NSString *base64Str = [_base64DataStr stringByReplacingOccurrencesOfString:@"data:video/mp4;base64," withString:@""];
        NSData *reData = [[NSData alloc] initWithBase64EncodedString:base64Str options:NSDataBase64DecodingIgnoreUnknownCharacters];
        _resumeData = reData;
    }
    return _resumeData;
}

- (NSString *)baseFilePath {
    return MLBASEFILEPATHaseFilePath;
}

- (UIImage *)preViewImage {
    if (!_preViewImage){
        if (_writeState == MLWriteStateFinish){
            AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:self.localUrl options:nil];
            AVAssetImageGenerator *assetGen = [[AVAssetImageGenerator alloc] initWithAsset:asset];

            assetGen.appliesPreferredTrackTransform = YES;
            CMTime time = CMTimeMakeWithSeconds(0.0, 600);
            NSError *error = nil;
            CMTime actualTime;
            CGImageRef image = [assetGen copyCGImageAtTime:time actualTime:&actualTime error:&error];
            UIImage *videoImage = [[UIImage alloc] initWithCGImage:image];
            CGImageRelease(image);
            _preViewImage = videoImage;
        }
    }
    return _preViewImage;
}

- (UIImage *)base64Image {
    if (!_base64Image){
        NSString *base64str = [PMLTools getTxtWithfileName:@"image" type:@"txt"];
        UIImage *base64Image = [UIImage imageWithBase64Str:base64str];
        _base64Image = base64Image;
    }
    return _base64Image;
}

+ (NSString *)getTxt {
    // 加载本地html.
    NSString *txtPath = [[NSBundle mainBundle]pathForResource:@"video" ofType:@"txt"];
    NSString *contentStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:txtPath] encoding:NSUTF8StringEncoding error:nil];
    return contentStr;
}

- (instancetype)initWithBase64DataStr:(NSString *)base64DataStr
                                  vid:(NSString *)vid
                           createTime:(NSString *)createTime {
    if (self = [super init]){
        _base64DataStr = base64DataStr;
        _vid = vid;
        _createTime = createTime;
    }
    return self;
}

@end
