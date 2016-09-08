//
//  TableViewController.m
//  监听tableViewCell中textField的值（一）
//
//  Created by wangsong on 16/5/3.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "CustomTextField.h"

@interface TableViewController ()<CustomCellCellDelegate>
/**
 *  标题
 */
@property(nonatomic, strong) NSArray *titles;
/**
 *  占位文字
 */
@property(nonatomic, strong) NSArray *placeHolders;
/**
 *  输入框内容
 */
@property(nonatomic, strong) NSMutableArray *contents;

@end

@implementation TableViewController
    static NSString * const ID = @"textFieldCell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tableView.rowHeight = 300;
}

#pragma mark - CustomCellCellDelegate
- (void)contentDidChanged:(NSString *)text forIndexPath:(NSIndexPath *)indexPath {
    [self.contents replaceObjectAtIndex:indexPath.row withObject:text];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.contentTextField.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *customCell = (TableViewCell *)cell;
    customCell.titleLabel.text = self.titles[indexPath.row];
    customCell.contentTextField.placeholder = self.placeHolders[indexPath.row];
    customCell.contentTextField.text = self.contents[indexPath.row];
}

- (NSArray *)titles
{
    if (!_titles) {
        _titles = @[@"姓名",@"年龄",@"地址",@"性别",@"爱好"];
    }
    return _titles;
}

- (NSArray *)placeHolders
{
    if (!_placeHolders) {
        _placeHolders = @[@"请输入姓名",@"请输入年龄",@"请输入地址",@"请输入性别",@"请输入爱好"];
    }
    return _placeHolders;
}

- (NSMutableArray *)contents {
    if (!_contents) {
        _contents = [NSMutableArray array];
        for (int i = 0; i < self.titles.count; i++) {
            [_contents addObject:@""];
        }
    }
    return _contents;
}

@end
