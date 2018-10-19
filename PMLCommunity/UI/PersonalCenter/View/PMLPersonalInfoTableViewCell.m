//
//  PMLPersonalInfoTableViewCell.m
//  PMLCommunity
//
//  Created by panchuang on 2018/10/10.
//  Copyright © 2018 MAYLOL. All rights reserved.
//

#import "PMLPersonalInfoTableViewCell.h"

@interface PMLPersonalInfoTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UITextField *rightField;

@end

@implementation PMLPersonalInfoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setTypeString:(NSString *)typeString {
    _typeString = typeString;
    self.leftLabel.text = _typeString;
}

- (void)setDataString:(NSString *)dataString {
    _dataString = dataString;
    if (_dataString.length > 0) {
        self.rightField.text = _dataString;
    }
}

- (void)setCellIndex:(NSInteger)cellIndex {
    _cellIndex = cellIndex;
}
- (void)setFieldEnableEdit:(BOOL)fieldEnableEdit {
    _fieldEnableEdit = fieldEnableEdit;
    _rightField.enabled = _fieldEnableEdit;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
