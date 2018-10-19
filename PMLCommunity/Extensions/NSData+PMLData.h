//
//  NSData+PMLData.h
//  PMLCommunity
//
//  Created by panchuang on 2018/10/11.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (PMLData)
//aes256加密
- (NSData *)AES256EncryptWithKey:(NSString *)key;
//aes256解密
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
