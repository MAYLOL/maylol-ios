//
//  PMLBeautyDiaryListHeaderView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/13.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

typedef NS_ENUM(NSInteger,HeaderSelectType) {
    MyDiary,
    ChangeDiary,
    LatestDiary,
};

typedef void(^BeautyDiaryListHeaderViewBlock)(NSInteger index);

@interface PMLBeautyDiaryListHeaderView : PMLBaseView
//设置默认点击按钮
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy) BeautyDiaryListHeaderViewBlock diaryHeaderBlock;
- (void)setselectBtn:(NSInteger)index;
@end
