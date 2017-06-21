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

@interface RootViewController ()<UITableViewDelegate,UITableViewDataSource,Delegate,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"ROOT_CELL"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self configSearchController];
}

-(void)didselect {
    DetailViewController *detailVC = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOT_CELL"];
    cell.textLabel.text = @"rootCell";
    return cell;
}
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
    
    [self.searchController.searchResultsController.view addObserver:self forKeyPath:@"hidden" options:0 context:NULL];
    
    
}



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

#pragma mark UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{

}

#pragma mark UISearchControllerDelegate
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

#pragma mark UISearchBarDelegate
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
