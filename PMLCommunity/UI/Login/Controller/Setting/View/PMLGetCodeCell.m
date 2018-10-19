//
//  PMLGetCodeCell.m
//  PMLCommunity
//
//  Created by 安跃超 on 2018/10/10.
//  Copyright © 2018年 MAYLOL. All rights reserved.
//

#import "PMLGetCodeCell.h"

@interface PMLGetCodeCell() <UITextFieldDelegate>
@property (nonatomic, copy, readwrite) NSString *fieldString;
@end

@implementation PMLGetCodeCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    // Initialization code
    self.getCodeBtn.backColor = [UIColor colorWithHex:@"#F02E44"];
    self.getCodeBtn.clickColor = [UIColor colorWithHex:@"#999999"];
    self.getCodeBtn.layer.cornerRadius = 5;
    self.getCodeBtn.layer.masksToBounds = true;
    [self.getCodeBtn addTarget:self action:@selector(clickCodeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.getCodeField setPlaceholder:kInternationalContent(@"输入验证码")];
    [self.getCodeBtn setTitle:kInternationalContent(@"发送验证码") forState:UIControlStateNormal];

}
- (void)clickCodeAction:(PMLGetCodeButton *)sender {
    [sender click];
    if (self.clickBlock){
        self.clickBlock();
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    self.getCodeField.placeholder = _placeholder;
}

- (void)setFileEnable:(BOOL)fileEnable {
    _fileEnable = fileEnable;
    self.getCodeField.enabled = _fileEnable;
}

- (void)setFieldText:(NSString *)fieldText {
    _fieldText = fieldText;
    if (_fieldText.length > 0) {
        self.getCodeField.text = _fieldText;
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
