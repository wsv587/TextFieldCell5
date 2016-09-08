//
//  TableViewCell.m
//  监听tableViewCell中textField的值（一）
//
//  Created by wangsong on 16/5/3.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import "TableViewCell.h"
#import "CustomTextField.h"

@interface TableViewCell ()<UITextFieldDelegate>


@end


@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentTextField addTarget:self action:@selector(contentDidChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)contentDidChanged:(id)sender {
    // 调用代理方法，告诉代理，哪一行的文本发生了改变
    if (self.delegate && [self.delegate respondsToSelector:@selector(contentDidChanged:forIndexPath:)]) {
        [self.delegate contentDidChanged:self.contentTextField.text forIndexPath:self.contentTextField.indexPath];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.contentTextField becomeFirstResponder];
}

@end
