//
//  SelectedNewsViewController.m
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 22.05.2021.
//

#import "SelectedNewsViewController.h"
#import "NewsItem.h"
#import <WebKit/WebKit.h>

@interface SelectedNewsViewController ()

@property (nonatomic) NewsItem *newsItem;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation SelectedNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViewController];
}

- (instancetype)initWithNewsItem:(NewsItem *)news {
    self = [super init];
    if (self) {
        _newsItem = news;
    }
    return self;
}

- (void)setupViewController {
    
    self.view.backgroundColor = [UIColor systemBackgroundColor];
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.navigationItem.backButtonTitle = @"";
    self.title = self.newsItem.sourceName;
    
    WKWebViewConfiguration *webConfiguration = [[WKWebViewConfiguration alloc] init];
    _webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:webConfiguration];
    NSURL *nsurl=[NSURL URLWithString:self.newsItem.newsURLString];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [_webView loadRequest:nsrequest];
    [self.view addSubview:_webView];
    
}

@end
