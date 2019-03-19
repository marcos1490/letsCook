//
//  ViewController.m
//  LetsCook
//
//  Created by Marco Salazar on 3/18/19.
//  Copyright © 2019 Marco Salazar. All rights reserved.
//

#import "ViewController.h"
#import "WebServices/WebServiceManager.h"
#import "RecipeTableViewCell.h"
#import "RecipeDetailViewController.h"
#import "MBProgressHUD.h"

@interface ViewController () <UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, weak) IBOutlet UIView *emptyView;
@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) NSArray *datasource;
@property (nonatomic, strong) NSArray *searchResults;
@property (nonatomic) BOOL isSearching;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    self.searchController.searchResultsUpdater = self;
    self.searchController.obscuresBackgroundDuringPresentation = NO;
    self.searchController.searchBar.placeholder = @"Search";
    
    self.navigationItem.titleView = self.searchController.searchBar;
    
    UIRefreshControl *contentRefreshControl = [[UIRefreshControl alloc]init];
    [contentRefreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
    self.tableView.refreshControl = contentRefreshControl;
    [self getRecipes];

    self.extendedLayoutIncludesOpaqueBars = YES;
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.searchController setActive:NO];
}

#pragma mark - Helpers
-(void)refreshData:(UIRefreshControl *)control {
    [control endRefreshing];
    [self getRecipes];
}

-(void)checkEmpty {
    NSInteger resultCount = self.isSearching ? self.searchResults.count : self.datasource.count;
    [self.emptyView setHidden:resultCount > 0];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.isSearching ? self.searchResults.count : self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecipeTableViewCell *cell = (RecipeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"recipeRow" forIndexPath:indexPath];
    Recipe *recipe = self.isSearching ? [self.searchResults objectAtIndex:indexPath.row] : [self.datasource objectAtIndex:indexPath.row];
    [cell configureWithRecipe:recipe];
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Recipe *recipe = self.isSearching ? [self.searchResults objectAtIndex:indexPath.row] : [self.datasource objectAtIndex:indexPath.row];
    [self getDetailForRecipe:recipe];
}

#pragma mark - UISearchResultsUpdatingDelegate

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    NSString *searchTerm = [searchController.searchBar.text stringByTrimmingCharactersInSet:NSCharacterSet.whitespaceAndNewlineCharacterSet];
    self.isSearching = searchController.isActive;
    self.searchResults = [self.datasource filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self.title contains[cd] %@", searchTerm]];
    [self.tableView reloadData];
    [self checkEmpty];
}

#pragma mark - WebServices
-(void)getRecipes {
    typeof(self) weakself = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WebServiceManager getRecipesWithCompletion:^(NSArray * _Nonnull recipes) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        weakself.datasource = recipes;
        [weakself.tableView reloadData];
        [weakself checkEmpty];
    } andError:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [weakself showMessage:error.localizedDescription withTitle:@"Let's Cook"];
    }];
}

-(void)getDetailForRecipe:(Recipe *)recipe {
    typeof(self) weakself = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WebServiceManager getRecipeDetail:recipe.recipeId withCompletion:^(RecipeDetail * _Nonnull recipe) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        RecipeDetailViewController *viewController = [RecipeDetailViewController instantiateWithRecipe:recipe];
        [weakself.navigationController pushViewController:viewController animated:YES];
    } andError:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:weakself.view animated:YES];
        [weakself showMessage:error.localizedDescription withTitle:@"Let's Cook"];
    }];
    
}

#pragma mark - UIAlertController

- (void)showMessage:(NSString *)message withTitle:(NSString *)title {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    [alert addAction:okAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}

@end
