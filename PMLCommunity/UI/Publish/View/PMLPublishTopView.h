//
//  PMLPublishTopView.h
//  PMLCommunity
//
//  Created by panchuang on 2018/9/28.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLBaseView.h"

@protocol PMLPublishTopViewDelegate <NSObject>
- (void)selectPlate;
@end

@interface PMLPublishTopView : PMLBaseView
@property (nonatomic,weak) id<PMLPublishTopViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
