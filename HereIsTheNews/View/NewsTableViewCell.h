//
//  NewsTableViewCell.h
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 21.05.2021.
//

#import <UIKit/UIKit.h>

@interface NewsTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *sourceLabel;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *descriptionLabel;

@end
