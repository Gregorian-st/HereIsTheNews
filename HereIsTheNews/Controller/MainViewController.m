//
//  MainViewController.m
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 21.05.2021.
//

#import "MainViewController.h"
#import "NewsTableViewCell.h"
#import "NewsItem.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"
#import "SelectedNewsViewController.h"

#define ReuseIdentifier @"NewsCell"

@interface MainViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) NSMutableArray *newsArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
    [self getAllNews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
}

- (void)setupViewController {
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.navigationController.navigationBar.prefersLargeTitles = YES;
    self.navigationItem.backButtonTitle = @"";
    self.title = @"Top News";
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.separatorColor = [UIColor systemGray2Color];
    _tableView.allowsMultipleSelection = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:_refreshControl];
}

- (void)getAllNews {
    [self.newsArray removeAllObjects];
    [[APIManager sharedInstance] newsForCountry:@"ru" withCompletion:^(NSArray *news) {
        if (news.count > 0) {
            self.newsArray = [[NSMutableArray alloc] initWithArray:news];
            [self.tableView reloadData];
        }
    }];
}

- (void)refresh:(UIRefreshControl *)sender {
    [self getAllNews];
}

// MARK: - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber *newsCount = [NSNumber numberWithInteger:[self.newsArray count]];
    if (newsCount.intValue == 0) {
        [self showEmptyMessage];
    } else {
        [self hideEmptyMessage];
    }
    return [self.newsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 2 * ([UIScreen mainScreen].bounds.size.width - 20) / 3 + 169;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseIdentifier];

    if (!cell) {
        cell = [[NewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ReuseIdentifier];
    }
    
    cell.titleLabel.text = @"";
    cell.sourceLabel.text = @"";
    cell.descriptionLabel.text = @"";

    NewsItem *news = [self.newsArray objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = news.title;
    
    NSURL *imageURL;
    @try {
        imageURL = [NSURL URLWithString:news.imageURLString];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
    } @finally {
        if(imageURL) {
            [cell.mainImageView setImageWithURL:imageURL];
        }
    }
    
    NSString *sourceLabelText = @"By: ";
    cell.sourceLabel.text = [sourceLabelText stringByAppendingString:news.sourceName];
    
    cell.descriptionLabel.text = news.descriptionText;

    return cell;
}

- (void)showEmptyMessage {
    CGFloat topHeight = self.navigationController.navigationBar.frame.size.height + [UIApplication sharedApplication].windows.lastObject.windowScene.statusBarManager.statusBarFrame.size.height;
    CGPoint centerPoint = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2 - topHeight);
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    activityIndicatorView.color = [UIColor systemGrayColor];
    activityIndicatorView.center = centerPoint;
    [activityIndicatorView startAnimating];
    [_tableView addSubview:activityIndicatorView];
}

- (void)hideEmptyMessage {
    for (UIActivityIndicatorView *subView in _tableView.subviews) {
        if ([subView isKindOfClass:[UIActivityIndicatorView class]]) {
            [subView removeFromSuperview];
        }
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 10, 0, 10);
    
    [_refreshControl endRefreshing];
}

// MARK: - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsItem *newsItem = [self.newsArray objectAtIndex:indexPath.row];
    
    NSURL *webURL;
    @try {
        webURL = [NSURL URLWithString:newsItem.imageURLString];
    } @catch (NSException *exception) {
        NSLog(@"%@", exception.reason);
        return;
    } @finally {

    }
    SelectedNewsViewController *selectedNewsViewController;
    selectedNewsViewController = [[SelectedNewsViewController alloc] initWithNewsItem:newsItem];
    [self.navigationController pushViewController: selectedNewsViewController animated:YES];
}

@end
