//
//  FSCategoryViewController.m
//  FSExtensionDemo
//
// Created by 曾福生 on 2019/12/27.
// Copyright (c) 2019 Fussa. All rights reserved.
//
#import "FSCategoryViewController.h"
#import "FSArrayViewController.h"

@interface FSCategoryViewController ()<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@end

@implementation FSCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Category";

    self.dataArray = @[
            @[@"Array", [FSArrayViewController class]],
    ];

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row][0];
    return cell;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Class aClass = self.dataArray[indexPath.row][1];
    [self.navigationController pushViewController:[[aClass alloc] init] animated:YES];
}


@end
