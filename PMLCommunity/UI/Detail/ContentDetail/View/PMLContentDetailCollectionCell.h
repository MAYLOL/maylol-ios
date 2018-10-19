//
//  PMLContentDetailCollectionCell.h
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/14.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface PMLContentDetailCollectionCell : UICollectionViewCell

@property (nonatomic,strong)NSString *htmlStr;
@property (nonatomic,strong)NSURL *htmlUrl;
@property (nonatomic,copy)void(^contentDetailHightBlock) (CGFloat height);//回调高度

@end
