//
//  NewsTableViewCell.m
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 21.05.2021.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    CGFloat cellWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat nextY = 0;
    
    if (self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, nextY + 10, cellWidth - 20, 48.0)];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:18.0 weight:UIFontWeightBold];
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview: _titleLabel];
        nextY = nextY + 10 + _titleLabel.frame.size.height;

        _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, nextY + 5, cellWidth - 20, 2 * (cellWidth - 20) / 3)];
        _mainImageView.contentMode = UIViewContentModeScaleAspectFit;
        _mainImageView.clipsToBounds = YES;
        [self.contentView addSubview: _mainImageView];
        nextY = nextY + 5 + _mainImageView.frame.size.height;
        
        _sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, nextY + 5, cellWidth - 20, 24.0)];
        _sourceLabel.textAlignment = NSTextAlignmentLeft;
        _sourceLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
        _sourceLabel.numberOfLines = 1;
        [self.contentView addSubview: _sourceLabel];
        nextY = nextY + 5 + _sourceLabel.frame.size.height;
        
        _descriptionLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, nextY, cellWidth - 20, 72.0)];
        _descriptionLabel.textAlignment = NSTextAlignmentLeft;
        _descriptionLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightRegular];
        _descriptionLabel.numberOfLines = 3;
        [self.contentView addSubview: _descriptionLabel];
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
