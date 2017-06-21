//
//  ResultViewController.m
//  SearchControllerTest
//
//  Created by Yubin on 2017/6/21.
//  Copyright © 2017年 X. All rights reserved.
//

#import "ResultViewController.h"
#import "DetailViewController.h"


@interface ResultViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *resultTalbeView;

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;

    [self.resultTalbeView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RESULT_CELL"];
    self.resultTalbeView.delegate = self;
    self.resultTalbeView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RESULT_CELL" forIndexPath:indexPath];
    cell.textLabel.text = @"asdasdasd";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_delegate && [_delegate respondsToSelector:@selector(didselect)]) {
        [_delegate didselect];
    }
}

@end
