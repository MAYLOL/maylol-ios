//
//  PMLCommentModel.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/9/17.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLCommentModel.h"
#import "PMLTools.h"

//#define     HEIGHT_MOMENT_DEFAULT       76.0f
#define     HEIGHT_MOMENT_DEFAULT       99.0f

@implementation PMLCommentFrameModel

@end

@implementation PMLCommentModel

#pragma mark - # Getter
- (PMLCommentFrameModel *)commentFrame
{
    if (_commentFrame == nil) {
        _commentFrame = [[PMLCommentFrameModel alloc] init];
        _commentFrame.height = HEIGHT_MOMENT_DEFAULT;
        _commentFrame.height += _commentFrame.heightDetail = self.detailModel.detailFrame.height;  //正文高度
//        _commentFrame.height += _commentFrame.heightExtension = self.extModel.extensionFrame.height;   //拓展高度
        _commentFrame.height2 = 0.0f;
        _commentFrame.height2 += _commentFrame.heightDetail2 = self.detailModel.detailFrame.height2;  //正文高度

    }
    return _commentFrame;
}

- (instancetype)initWithmodel:(PMLCommentModel *)model {

    if (self = [super init]){
        _authorUserId = model.authorUserId;
        _commentId = model.commentId;
        _contentId = model.contentId;
        _createTime = model.createTime;
        _isChecked = model.isChecked;
        _isRecommend = model.isRecommend;
        _praiseCount = model.praiseCount;
        NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:model.createTime/1000];
        _date = detaildate;
        NSMutableArray *userArr = [NSMutableArray new];
        for (PMLCommentReplyModel *replyModel in model.extModel.replyList) {
            PMLCommentUserModel  *user = [PMLCommentUserModel initWithUserModel:replyModel.user];
            PMLCommentUserModel *toUser = [PMLCommentUserModel initWithUserModel:replyModel.toUser];
            PMLCommentReplyModel *reply = [PMLCommentReplyModel initWithFromUser:user toUser:toUser content:replyModel.content praiseCount:replyModel.praiseCount createTime:replyModel.createTime];
            [userArr addObject:reply];
        }
        PMLCommentUserModel *user = [PMLCommentUserModel initWithUserModel:model.user];
        PMLCommentExtModel *extension = [PMLCommentExtModel initWithReplyList:userArr];
        PMLCommentDetailModel *detail = [PMLCommentDetailModel initWithCommentText:model.detailModel.text];
        _user = user;
        _detailModel = detail;
        _extModel = extension;
    }
    return self;
}

+ (instancetype)initWithmodel:(PMLCommentModel *)model {
    PMLCommentModel *comment =  [[PMLCommentModel alloc]initWithmodel:model];
    return comment;
}

/**
 *  ///////////////////////列表测试数据////////////////////////
 **/
+ (NSArray<PMLCommentModel *> *)getPMLContentCommentListModel {
    NSMutableArray *commentList = [NSMutableArray new];

    NSArray *commentsList = @[@"哈哈哈不错不错666",@"哈哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错666"];
    NSMutableArray *userArr = [NSMutableArray new];
    PMLCommentExtModel *extension = [PMLCommentExtModel initWithReplyList:userArr];
    for (int i = 0; i < commentsList.count ; i ++) {
        PMLCommentModel *commentModel = [PMLCommentModel new];
        commentModel.currentuserID = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:0 to:100]];
        commentModel.authorUserId = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:0 to:100]];
        commentModel.commentId = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:100 to:200]];
        commentModel.contentId = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:200 to:300]];
        commentModel.createTime = 1537164211000;
        commentModel.praiseCount = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:200 to:300]];
        commentModel.isChecked = @"0";
        commentModel.isRecommend = @"1";

        PMLCommentUserModel *user = [[PMLCommentUserModel alloc] init];
        user.identity = [NSString stringWithFormat:@"identity10%d",i];
        user.realname = [NSString stringWithFormat:@"realname1028%d",i];
        user.registerIp = [NSString stringWithFormat:@"realname192.198.1.%d",i];
        user.tel = [NSString stringWithFormat:@"151312223%d",i];
        user.email = [NSString stringWithFormat:@"1234562%d3@qq.com",i];
        user.userId = [NSString stringWithFormat:@"10%d",i];
        user.userImg = [NSString stringWithFormat:@"home_tab_me_normal"];
        user.username = [NSString stringWithFormat:@"realname1028%d",i];

        commentModel.user = user;
        PMLCommentDetailModel *detail = [PMLCommentDetailModel new];
        detail.text = commentsList[i];
        commentModel.detailModel = detail;
        commentModel.extModel = extension;
        [commentList addObject:commentModel];
    }
    return commentList;
}
/**
 *  ///////////////////////测试数据////////////////////////
 **/
+ (NSArray<PMLCommentModel *> *)getPMLCommentListModel {

    NSMutableArray *commentList = [NSMutableArray new];

    NSArray *commentsList = @[@"哈哈哈不错不错666",@"哈哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错66哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666哈哈不错不错666哈哈不错不错666哈哈不错不错666哈哈不错不错666哈哈不错不错666哈哈不错不错666哈哈不错不错666哈哈不错不错666",@"哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666",@"哈哈哈不错不错666"];

  int arcReplyCount = [PMLTools getRandomNumber:0 to:10];
    NSMutableArray *userArr = [NSMutableArray new];
    for (int i =0; i < arcReplyCount; i ++) {
        PMLCommentUserModel *user = [[PMLCommentUserModel alloc] init];
        user.identity = [NSString stringWithFormat:@"identity10%d",i];
        user.realname = [NSString stringWithFormat:@"realname1028%d",i];
        user.registerIp = [NSString stringWithFormat:@"realname192.198.1.%d",i];
        user.tel = [NSString stringWithFormat:@"151312223%d",i];
        user.email = [NSString stringWithFormat:@"1234562%d3@qq.com",i];
        user.userId = [NSString stringWithFormat:@"10%d",i];
        user.userImg = [NSString stringWithFormat:@"home_tab_me_normal"];
        user.username = [NSString stringWithFormat:@"realname1028%d",i];

        PMLCommentUserModel *touser = [[PMLCommentUserModel alloc] init];
        touser.identity = [NSString stringWithFormat:@"identity10%d",i];
        touser.realname = [NSString stringWithFormat:@"realname1028%d",i];
        touser.registerIp = [NSString stringWithFormat:@"realname192.198.1.%d",i];
        touser.tel = [NSString stringWithFormat:@"151312223%d",i];
        touser.email = [NSString stringWithFormat:@"1234562%d3@qq.com",i];
        touser.userId = [NSString stringWithFormat:@"10%d",i];
        touser.userImg = [NSString stringWithFormat:@"home_tab_me_normal"];
        touser.username = [NSString stringWithFormat:@"realname1028%d",i];
        PMLCommentReplyModel *replyModel = [PMLCommentReplyModel new];
        replyModel.user = user;
        replyModel.toUser = touser;
        replyModel.content = commentsList[i];
        replyModel.createTime = 1537164211000;
        replyModel.praiseCount = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:200 to:300]];
        [userArr addObject:replyModel];
    }
    PMLCommentExtModel *extension = [PMLCommentExtModel initWithReplyList:userArr];
    for (int i = 0; i < commentsList.count ; i ++) {
        PMLCommentModel *commentModel = [PMLCommentModel new];
        commentModel.currentuserID = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:0 to:100]];
        commentModel.authorUserId = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:0 to:100]];
        commentModel.commentId = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:100 to:200]];
        commentModel.contentId = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:200 to:300]];
        commentModel.createTime = 1537164211000;
        commentModel.praiseCount = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:200 to:300]];
        commentModel.isChecked = @"0";
        commentModel.isRecommend = @"1";

        PMLCommentUserModel *user = [[PMLCommentUserModel alloc] init];
        user.identity = [NSString stringWithFormat:@"identity10%d",i];
        user.realname = [NSString stringWithFormat:@"realname1028%d",i];
        user.registerIp = [NSString stringWithFormat:@"realname192.198.1.%d",i];
        user.tel = [NSString stringWithFormat:@"151312223%d",i];
        user.email = [NSString stringWithFormat:@"1234562%d3@qq.com",i];
        user.userId = [NSString stringWithFormat:@"10%d",i];
        user.userImg = [NSString stringWithFormat:@"home_tab_me_normal"];
        user.username = [NSString stringWithFormat:@"realname1028%d",i];

        commentModel.user = user;
        PMLCommentDetailModel *detail = [PMLCommentDetailModel new];
        detail.text = commentsList[i];
        commentModel.detailModel = detail;
        commentModel.extModel = extension;
        [commentList addObject:commentModel];
    }
    return commentList;
}

+ (NSArray<PMLCommentModel *> *)insertCommentWithcontentId:(NSString *)contentId commentText:(NSString *)commentText user:(PMLCommentUserModel *)user commentList:(NSArray<PMLCommentModel *> *)commentList {

    PMLCommentModel *commentModel = [PMLCommentModel new];
    commentModel.currentuserID = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:0 to:100]];
    commentModel.authorUserId = contentId;
    commentModel.commentId = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:100 to:200]];
    commentModel.contentId = [NSString stringWithFormat:@"%d",[PMLTools getRandomNumber:200 to:300]];
    commentModel.createTime = [[NSDate date] timeIntervalSince1970];
    commentModel.isChecked = @"0";
    commentModel.isRecommend = @"1";
    commentModel.user = user;
    PMLCommentDetailModel *detail = [PMLCommentDetailModel new];
    detail.text = commentText;
    commentModel.detailModel = detail;
    commentModel.extModel = nil;
    NSMutableArray *userArr = [NSMutableArray new];
    [userArr addObjectsFromArray:commentList];
    [userArr insertObject:commentModel atIndex:0];
    return userArr;
}

+ (PMLCommentModel *)insertCommentWithcommentId:(NSString *)commentId replyText:(NSString *)replyText user:(PMLCommentUserModel *)user commentModel:(PMLCommentModel *)commentModel {

    PMLCommentUserModel *touser = [[PMLCommentUserModel alloc] init];
    touser.identity = [NSString stringWithFormat:@"identity10"];
    touser.realname = [NSString stringWithFormat:@"realname1028"];
    touser.registerIp = [NSString stringWithFormat:@"realname192.198.1.1"];
    touser.tel = [NSString stringWithFormat:@"151312223"];
    touser.email = [NSString stringWithFormat:@"12345623@qq.com"];
    touser.userId = [NSString stringWithFormat:@"10"];
    touser.userImg = [NSString stringWithFormat:@"home_tab_me_normal"];
    touser.username = [NSString stringWithFormat:@"realname1028"];

    PMLCommentReplyModel *replyModel = [PMLCommentReplyModel new];
    replyModel.user = user;
    replyModel.toUser = touser;
    replyModel.content = replyText;
    replyModel.createTime = [[NSDate date] timeIntervalSince1970];

    PMLCommentModel *cModel = [PMLCommentModel new];
    cModel.currentuserID = commentModel.currentuserID;
    cModel.authorUserId = commentModel.authorUserId;
    cModel.commentId = commentId;
    cModel.contentId = commentModel.contentId;
    cModel.createTime = commentModel.createTime;
    cModel.isChecked = commentModel.isChecked;
    cModel.isRecommend = commentModel.isRecommend;
    cModel.user = user;
    cModel.detailModel = commentModel.detailModel;
    NSMutableArray *replyL = [NSMutableArray new];
    [replyL addObjectsFromArray:commentModel.extModel.replyList];
    [replyL insertObject:replyModel atIndex:0];
    PMLCommentExtModel *extM = [PMLCommentExtModel initWithReplyList:replyL];
    cModel.extModel = extM;
    return cModel;
}

+ (PMLCommentUserModel *)getCurrentUser {
    PMLCommentUserModel *touser = [[PMLCommentUserModel alloc] init];
    touser.identity = [NSString stringWithFormat:@"identity10"];
    touser.realname = [NSString stringWithFormat:@"realname1028"];
    touser.registerIp = [NSString stringWithFormat:@"realname192.198.1.1"];
    touser.tel = [NSString stringWithFormat:@"151312223"];
    touser.email = [NSString stringWithFormat:@"12345623@qq.com"];
    touser.userId = [NSString stringWithFormat:@"10"];
    touser.userImg = [NSString stringWithFormat:@"home_tab_me_normal"];
    touser.username = [NSString stringWithFormat:@"realname1028"];
    return touser;
}

@end
