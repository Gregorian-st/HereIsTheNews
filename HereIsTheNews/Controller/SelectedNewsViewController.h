//
//  SelectedNewsViewController.h
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 22.05.2021.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"

@interface SelectedNewsViewController : UIViewController

- (instancetype)initWithNewsItem:(NewsItem *)news;

@end
