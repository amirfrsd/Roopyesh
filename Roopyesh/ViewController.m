//
//  ViewController.m
//  Roopyesh
//
//  Created by Amir on 8/22/17.
//  Copyright © 2017 Emersad. All rights reserved.
//

#import "ViewController.h"
#import "CoreNetworking.h"
#import "CoreUtils.h"
#import "MoviesTableViewCell.h"
#import "MasterViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UIRefreshControl *refreshControl;
@property NSMutableArray *dataSource;
@end

@implementation ViewController

- (void)getShowsForMe {
    [CoreUtils showProgressHUD];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        [CoreNetworking getShows:^(BOOL success, id response) {
            if (success) {
                self.dataSource = [CoreUtils parseServerResponse:response];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    [CoreUtils dismissProgressHUD];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [CoreUtils dismissProgressHUD];
                });
            }
        }];
    });
    [self.refreshControl endRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = [[NSMutableArray alloc] init];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorWithRed:0.90 green:0.00 blue:0.33 alpha:1.0];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(getShowsForMe)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    [self getShowsForMe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View Delegates
- (void)configureCell:(MoviesTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:[self.dataSource[indexPath.row] valueForKey:@"image"]] placeholderImage:[UIImage imageNamed:@"default-thumbnail"]];
    cell.nameLabel.text = [self.dataSource[indexPath.row] valueForKey:@"name"];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *movieCell = @"MovieCell";
    MoviesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:movieCell];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MoviesTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    MasterViewController *masterViewController = [storyboard instantiateViewControllerWithIdentifier:@"MasterView"];
    masterViewController.idOfShow = [[self.dataSource[indexPath.row] valueForKey:@"id"] intValue];
    masterViewController.movieName = [self.dataSource[indexPath.row] valueForKey:@"name"];
    masterViewController.summary = [self.dataSource[indexPath.row] valueForKey:@"summary"];
    masterViewController.image = cell.imageView.image;
    masterViewController.rating = [self.dataSource[indexPath.row] valueForKey:@"rating"];
    masterViewController.premiered = [self.dataSource[indexPath.row] valueForKey:@"premiered"];
    masterViewController.language = [self.dataSource[indexPath.row] valueForKey:@"language"];
    [self.navigationController pushViewController:masterViewController animated:YES];
}
@end
