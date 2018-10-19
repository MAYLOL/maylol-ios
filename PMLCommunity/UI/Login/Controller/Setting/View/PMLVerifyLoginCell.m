//
//  PMLVerifyLoginCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/9.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLVerifyLoginCell.h"

@interface PMLVerifyLoginCell() <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *contentField;

@property (nonatomic, copy, readwrite) NSString *fieldString;

@end

@implementation PMLVerifyLoginCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentField.delegate = self;
    self.arrowImageView.hidden = true;
    self.bottonLine.hidden = true;
    // Initialization code
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.contentField.placeholder = _placeholder;
}

- (void)setFileEnable:(BOOL)fileEnable {
    _fileEnable = fileEnable;
    self.contentField.enabled = _fileEnable;
}

- (void)setFieldText:(NSString *)fieldText {
    _fieldText = fieldText;
    if (_fieldText.length > 0) {
        self.contentField.text = _fieldText;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark-UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@""]) {//如果按得是删除键
        self.fieldString = [textField.text substringToIndex:range.location];
    }else {
        self.fieldString = textField.text;
    }
    if (self.inputBlock) {
        self.inputBlock();
    }
    return YES;
}

@end
