//
//  NSString+PMLString.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(PMLString)
+ (BOOL)JudgeStringIsContainEmoji:(NSString *)emoji;
//aes256加密
- (NSString *)AES256EncryptWithKey:(NSString *)key;
//aes256解密
- (NSString *)AES256DecryptWithKey:(NSString *)key;
@end
