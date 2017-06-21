//
//  RootViewController.m
//  SearchControllerTest
//
//  Created by Yubin on 2017/6/21.
//  Copyright © 2017年 X. All rights reserved.
//

#import "RootViewController.h"
#import "ResultViewController.h"
#import "DetailViewController.h"

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource,ResultViewControllerDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSMutableArray *rootDataSource;
@property (nonatomic, strong) NSMutableArray *resultDataSource;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ROOT_CELL"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self configSearchController];
}

#pragma mark - UITalbeViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.rootDataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOT_CELL"];
    
    cell.textLabel.text = [self.rootDataSource objectAtIndex:indexPath.row];
    
    return cell;
}


- (void)resultViewController:(UIViewController *)vc didSelectRow:(NSIndexPath *)indexPath; {
    NSString *str = [self.resultDataSource objectAtIndex:indexPath.row];
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    detailVC.contentStr = str;
    [self.navigationController pushViewController:detailVC animated:YES];
}

// 配置 UISearchController
- (void)configSearchController {
    
    ResultViewController *resultVC = [[ResultViewController alloc] initWithNibName:@"ResultViewController" bundle:nil];
    resultVC.delegate = self;
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:resultVC];
    self.searchController.delegate = self;
    self.searchController.searchResultsUpdater = self;
    self.searchController.searchBar.delegate = self;
    self.searchController.dimsBackgroundDuringPresentation = YES;
    self.searchController.obscuresBackgroundDuringPresentation = YES;
    self.searchController.hidesNavigationBarDuringPresentation = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;
    [self.searchController.searchResultsController.view addObserver:self forKeyPath:@"hidden" options:0 context:NULL];
    
}

// 监听 self.searchController.searchResultsController.view 的hidden属性，让搜索结果页面一直显示
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ( object == self.searchController.searchResultsController.view &&
        [keyPath isEqualToString:@"hidden"] &&
        self.searchController.searchResultsController.view.hidden &&
        self.searchController.searchBar.isFirstResponder )
    {
        self.searchController.searchResultsController.view.hidden = NO;
    }
}

// 数据源
- (NSMutableArray *)rootDataSource
{
    if (!_rootDataSource) {
        NSMutableArray *mArray = [NSMutableArray array];
        for (int i = 0; i < 20; i ++) {
            NSString *str = [NSString stringWithFormat:@"第%d行",i];
            [mArray addObject:str];
        }
        _rootDataSource = mArray;
    }
    return _rootDataSource;
}

// 搜索过滤
- (NSMutableArray *)filterDataSourceWithStr:(NSString *)keyWords
{
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSString *str in self.rootDataSource) {
        if ([str containsString:keyWords]) {
            [mArray addObject:str];
        }
    }
    return mArray;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *keywords = searchController.searchBar.text;
    self.resultDataSource = [self filterDataSourceWithStr:keywords];
    ResultViewController *resultVC = (ResultViewController*)searchController.searchResultsController;
    resultVC.dataSource = self.resultDataSource;
    [resultVC.resultTalbeView reloadData];
}

#pragma mark - UISearchControllerDelegate
- (void)willPresentSearchController:(UISearchController *)searchController
{

}

- (void)didPresentSearchController:(UISearchController *)searchController
{

}

- (void) willDismissSearchController:(UISearchController *)searchController
{
    
}

- (void)didDismissSearchController:(UISearchController *)searchController
{
    
}

- (void)presentSearchController:(UISearchController *)searchController
{
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{

}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{

}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{

}

@end
