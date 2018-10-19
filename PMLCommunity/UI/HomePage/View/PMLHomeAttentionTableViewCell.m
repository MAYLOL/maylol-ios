//
//  PMLHomeAttentionTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/8/16.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLHomeAttentionTableViewCell.h"
#import "PMLFreeButton.h"
#import "PMLCommentDetailView.h"

static NSString *const HomeAttentionCommentCellID = @"PMLHomeAttentionCommentCellID";//默认

@interface PMLHomeAttentionCommentCell()
@property (nonatomic, strong) UILabel *commentLabel;
@property (nonatomic, strong) NSString *detail;
@end

@implementation PMLHomeAttentionCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self addSubview:self.commentLabel];
        [self.commentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.and.top.mas_equalTo(self);
        }];

    }
    return self;
}

- (void)setCommentModel:(PMLCommentModel *)commentModel {
    self.commentLabel.attributedText = [PMLHomeAttentionCommentCell calculateAttHeightWithTitle:commentModel.detailModel.text User:commentModel.user.username];
    [self.commentLabel sizeToFit];
}

+ (NSMutableAttributedString *)calculateAttHeightWithTitle:(NSString *)title User:(NSString *)user{
    //title
    NSString *userStr = [NSString stringWithFormat:@"%@: ",user];
    NSString *str = [NSString stringWithFormat:@"%@%@",userStr,title];
    NSMutableParagraphStyle *paragraphTitleStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphTitleStyle.alignment = NSTextAlignmentLeft;
//    paragraphTitleStyle.lineSpacing = 0.5;
//customPingFRegularFontWithSize
//    customPingFSemiboldFontWithSize
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:str];
    [attString setAttributes:@{NSFontAttributeName :[UIFont customPingFRegularFontWithSize:11],NSForegroundColorAttributeName:[UIColor colorWithHex:@"#262626"]} range:NSMakeRange(0, attString.length)];
    [attString setAttributes:@{NSFontAttributeName :[UIFont customPingFSemiboldFontWithSize:11],NSForegroundColorAttributeName:[UIColor colorWithHex:@"#000000"]} range:[str rangeOfString:userStr]];

    [attString addAttribute:NSParagraphStyleAttributeName value:paragraphTitleStyle range:NSMakeRange(0, attString.length)];

    return attString;
}

- (void)setDetail:(NSString *)detail
{
    _detail = detail;
    [self.textLabel setText:detail];
    //    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
    //        make.height.mas_equalTo(detail.detailFrame.heightText);
    //    }];
}

#pragma mark - # Getter
- (UILabel *)commentLabel
{
    if (_commentLabel == nil) {
        _commentLabel = [[UILabel alloc] init];
        [_commentLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_commentLabel setTextColor:[UIColor colorWithHex:@"#666666"]];
        [_commentLabel setNumberOfLines:0];
    }
    return _commentLabel;
}

@end

@interface PMLHomeAttentionCommentView()<UITableViewDelegate, UITableViewDataSource, PMLCommentDelegate>

@end
@implementation PMLHomeAttentionCommentView

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]){
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor whiteColor];
    self.delegate = self;
    self.dataSource = self;
    [self registerClass:[PMLHomeAttentionCommentCell class] forCellReuseIdentifier:HomeAttentionCommentCellID];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.showsVerticalScrollIndicator = NO;
    self.estimatedSectionFooterHeight = 0.01;
    self.estimatedSectionHeaderHeight = 0.01;
}

- (void)setCommentList:(NSArray<PMLCommentModel *> *)commentList {
    if (_commentList != commentList) {
        _commentList = commentList;
        [self reloadData];
    }

}
//评论详情页面
- (void)gotoCommentListPage {
    if (self.commentDelegate != nil && [self.commentDelegate respondsToSelector:@selector(gotoCommentListPage)]){
        [self.commentDelegate gotoCommentListPage];
    }
}
//评论回复页面
- (void)gotoReplyListPageWithCommentModel:(PMLCommentModel *)commentModel {
    if (self.commentDelegate != nil && [self.commentDelegate respondsToSelector:@selector(gotoReplyListPageWithCommentModel:)]){
        [self.commentDelegate gotoReplyListPageWithCommentModel:commentModel];
    }
}

#pragma mark-UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PMLHomeAttentionCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeAttentionCommentCellID forIndexPath:indexPath];
    cell.commentDelgate = self;
    cell.commentModel = _commentList[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMLCommentModel *commentModel = _commentList[indexPath.row];
    CGFloat comHeight = commentModel.commentFrame.height2;
    return comHeight + 5 ?: 0.01;
}
@end

@interface PMLHomeAttentionTableViewCell ()
@property (nonatomic, strong) UIImageView *iconImageView;//头像
@property (nonatomic, strong) PMLBaseLabel *nameLabel;//名字
@property (nonatomic, strong) UIButton *moreBtn;//更多
//@property (nonatomic, strong) UIView *centerView;//存放中间内容的容器

@property (nonatomic, strong) PMLFreeButton *commentBtn;//评论按钮
@property (nonatomic, strong) PMLFreeButton *praiseBtn;//点赞按钮
@property (nonatomic, strong) PMLBaseLabel *contentLabel;//文字内容
@property (nonatomic, strong) PMLBaseLabel *timeLabel;//时间
@property (nonatomic, strong) PMLBaseLabel *firstCommentLabel;//第一条评论
@property (nonatomic, strong) PMLBaseLabel *secondCommentLabel;//第二条评论
@property (nonatomic, strong) PMLFreeButton *lookUpDetailBtn;//查看详情按钮
@property (nonatomic, strong) UIImageView *dottedLineImageView;//底部虚线

@end

@implementation PMLHomeAttentionTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubViews];
    }
    return self;
}

- (void)setUpSubViews
{
    _iconImageView = [[UIImageView alloc] init];
    _iconImageView.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(26);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self.contentView layoutIfNeeded];

    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.iconImageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:self.iconImageView.bounds.size];

    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.iconImageView.bounds;
    maskLayer.path = path.CGPath;
    self.iconImageView.layer.mask = maskLayer;

    _nameLabel = [[PMLBaseLabel alloc] init];
    _nameLabel.textColor = [UIColor colorWithHex:@"#262626"];
    _nameLabel.font = [UIFont customPingFSemiboldFontWithSize:13];
    [_nameLabel sizeToFit];
    _nameLabel.text = kInternationalContent(@"你好啊");
    [self.contentView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.centerY.equalTo(self.iconImageView);
    }];

    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_moreBtn setImage:kImageWithName(@"home_follow_icon_more") forState:UIControlStateNormal];
    [_moreBtn addTarget:self action:@selector(moreBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [_moreBtn sizeToFit];
    [self.contentView addSubview:_moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-27);
        make.centerY.equalTo(self.iconImageView);
    }];

    _centerView = [[UIView alloc] init];
    _centerView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:_centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.right.equalTo(self.contentView).offset(-15);
        make.top.equalTo(self.iconImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(self.centerView.mas_width).multipliedBy(185.0/345);
    }];
    //    if (self.isVideo){
    _contentImageView = [[UIImageView alloc] init];
    _contentImageView.userInteractionEnabled = true;
    _contentImageView.contentMode = UIViewContentModeScaleAspectFill;
    _contentImageView.clipsToBounds = true;
    //    }
    [_centerView addSubview:_contentImageView];
    [_contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.centerView.mas_left).offset(0);
        make.right.equalTo(self.centerView.mas_right).offset(0);
        make.top.equalTo(self.centerView.mas_top).offset(0);
        make.height.mas_equalTo(self.centerView.mas_width).multipliedBy(185.0/345);
    }];
    //    }
    _commentBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    UIImage *commentImage = kImageWithName(@"home_follow_icon_coment");
    [_commentBtn setImage:commentImage forState:UIControlStateNormal];
    [_commentBtn setTitle:@"999+" forState:UIControlStateNormal];
    [_commentBtn setTitleColor:[UIColor colorWithHex:@"#000000"] forState:UIControlStateNormal];
    _commentBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:7];
    [_commentBtn setUpImageViewSize:commentImage.size margin:2 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [self.contentView addSubview:_commentBtn];
    [_commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.top.equalTo(self.centerView.mas_bottom).offset(16);
    }];

    _praiseBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    UIImage *praiseImage = kImageWithName(@"follow_like");
    UIImage *praiseImageClick = kImageWithName(@"follow_like_click");
    [_praiseBtn setImage:praiseImage forState:UIControlStateNormal];
    [_praiseBtn setImage:praiseImageClick forState:UIControlStateSelected];
    [_praiseBtn setTitle:@"999+" forState:UIControlStateNormal];
    [_praiseBtn setTitleColor:[UIColor colorWithHex:@"#000000"] forState:UIControlStateNormal];
    _praiseBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:7];
    [_praiseBtn setUpImageViewSize:praiseImage.size margin:2 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [self.contentView addSubview:_praiseBtn];
    [_praiseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentBtn.mas_right).offset(6);
        make.top.equalTo(self.commentBtn);
    }];

    _contentLabel = [[PMLBaseLabel alloc] init];
    _contentLabel.textColor = [UIColor colorWithHex:@"#262626"];
    _contentLabel.font = [UIFont customPingFRegularFontWithSize:11];
    _contentLabel.text = kInternationalContent(@"安居客都会看见爱上就肯定是你买房不是的目标分解和我爸厚积而薄发金山毒霸分别是你们都不能行吗奥斯卡大环境看撒谎抠脚大汉时间开放建设大街几千万IE很快就好的款式不方便说的南方比较合适");
    [_contentLabel sizeToFit];
    _contentLabel.numberOfLines = 3;
    [self.contentView addSubview:_contentLabel];
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.right.equalTo(self.moreBtn);
        make.top.equalTo(self.commentBtn.mas_bottom).offset(13);
    }];

    _timeLabel = [[PMLBaseLabel alloc] init];
    _timeLabel.textColor = [UIColor colorWithHex:@"#808080"];
    _timeLabel.font = [UIFont customPingFMediumFontWithSize:9];
    _timeLabel.text = @"08-03 15:58";
    [_timeLabel sizeToFit];
    [self.contentView addSubview:_timeLabel];
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentLabel);
        make.top.equalTo(self.contentLabel.mas_bottom).offset(13);
    }];

    _firstCommentLabel = [[PMLBaseLabel alloc] init];
    //    _firstCommentLabel.text = NSLocalizedString(<#key#>, <#comment#>)
    [self.contentView addSubview:_firstCommentLabel];

    _secondCommentLabel = [[PMLBaseLabel alloc] init];
    [self.contentView addSubview:_secondCommentLabel];

    //comment
    _commentView = [[PMLHomeAttentionCommentView alloc] initWithFrame: CGRectZero];
    [self.contentView addSubview:_commentView];
    [_commentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.top.equalTo(self.timeLabel.mas_bottom).offset(14);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.contentView.mas_right).offset(-26);
    }];
    [self.contentView layoutIfNeeded];
    //comment

    _lookUpDetailBtn = [PMLFreeButton buttonWithType:UIButtonTypeCustom];
    _lookUpDetailBtn.titleLabel.font = [UIFont customPingFMediumFontWithSize:9];
    [_lookUpDetailBtn setTitleColor:[UIColor colorWithHex:@"#808080"] forState:UIControlStateNormal];
//    [_lookUpDetailBtn setTitle:kInternationalContent(@"查看详情") forState:UIControlStateNormal];
    [_lookUpDetailBtn setTitle:kInternationalContent(@"点击评论") forState:UIControlStateNormal];
    UIImage *detailImage = kImageWithName(@"home_detail_icon");
    [_lookUpDetailBtn setImage:detailImage forState:UIControlStateNormal];
    [_lookUpDetailBtn setUpImageViewSize:detailImage.size margin:5 alignment:PMLFreeBtnAlignmentHorizontalLeft];
    [_lookUpDetailBtn addTarget:self action:@selector(pressAction:) forControlEvents:UIControlEventTouchUpInside];
    [_lookUpDetailBtn sizeToFit];
    [self.contentView addSubview:_lookUpDetailBtn];

    [_lookUpDetailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView);
        make.top.equalTo(self.commentView.mas_bottom).offset(14);
    }];

    _dottedLineImageView = [[UIImageView alloc] initWithImage:kImageWithName(@"dotted_line")];
    [self.contentView addSubview:_dottedLineImageView];
    [_dottedLineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(1);
    }];
}

- (void)setCommentHeight:(CGFloat)commentHeight {
    [_commentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(commentHeight);
    }];
    [_commentView layoutSubviews];
}

- (void)moreBtnClicked
{

}

- (void)pressAction:(UIButton *)sender {
    self.clickAction();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end

