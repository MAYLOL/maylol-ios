//
//  PMLSelectedPlateTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/9/25.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLSelectedPlateTableViewCell.h"

@interface PMLSelectedPlateTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation PMLSelectedPlateTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setContent:(NSString *)content {
    _content = content;
    _contentLabel.text = _content;
}

- (void)setShowLine:(BOOL)showLine {
    _showLine = showLine;
    _lineView.hidden = _showLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
