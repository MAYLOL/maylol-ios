//
//  PMLPhonePrefixCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/8.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLPhonePrefixCell.h"

@interface PMLPhonePrefixCell ()
@property (nonatomic, strong) PMLBaseLabel *nameLabel;
@property (nonatomic, strong) PMLBaseLabel *zoneCodeLabel;
@property (nonatomic, strong) PMLBaseView *lineBottom;
@end

@implementation PMLPhonePrefixCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    self.nameLabel =
    ({
        PMLBaseLabel *nameLabel = [[PMLBaseLabel alloc] init];
        nameLabel.frame = CGRectMake(15, 17, 200, 13);
        nameLabel.font = [UIFont fontWithName:@"Helvetica" size:14];
        [self.contentView addSubview:nameLabel];
        nameLabel;
    });
    
    self.zoneCodeLabel =
    ({
        PMLBaseLabel *nameDescLabel = [[PMLBaseLabel alloc] init];
        nameDescLabel.frame = CGRectMake(self.frame.size.width - 30, 17, 60, 13);
        nameDescLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        nameDescLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:nameDescLabel];
        nameDescLabel;
    });
    
    
    self.lineBottom =
    ({
        PMLBaseView *lineBottom = [[PMLBaseView alloc] initWithFrame:CGRectMake(15, 44, self.frame.size.width - 30,1)];
        lineBottom.backgroundColor = [UIColor colorWithHex:@"#E0E0E6"];
        [self.contentView addSubview:lineBottom];
        
        lineBottom;
    });
    
    _nameLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    _zoneCodeLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    _zoneCodeLabel.textColor = [UIColor colorWithHex:@"#C7C7C7"];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.lineBottom.frame = CGRectMake(15, 44, self.frame.size.width - 30,1);
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
