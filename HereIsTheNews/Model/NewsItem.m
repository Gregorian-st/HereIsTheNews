//
//  NewsItem.m
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 21.05.2021.
//

#import "NewsItem.h"

@implementation NewsItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    
    if (self) {
        NSDictionary *json = [dictionary valueForKey:@"source"];
        _sourceId = [json valueForKey:@"id"];
        if ([_sourceId isKindOfClass:[NSNull class]]) {
            _sourceId = @"";
        }
        _sourceName = [json valueForKey:@"name"];
        if ([_sourceName isKindOfClass:[NSNull class]]) {
            _sourceName = @"";
        }
        _author = [dictionary valueForKey:@"author"];
        if ([_author isKindOfClass:[NSNull class]]) {
            _author = @"-";
        }
        _title = [dictionary valueForKey:@"title"];
        if ([_title isKindOfClass:[NSNull class]]) {
            _title = @"";
        }
        _descriptionText = [dictionary valueForKey:@"description"];
        if ([_descriptionText isKindOfClass:[NSNull class]]) {
            _descriptionText = @"";
        }
        _newsURLString = [dictionary valueForKey:@"url"];
        if ([_newsURLString isKindOfClass:[NSNull class]]) {
            _newsURLString = @"";
        }
        _imageURLString = [dictionary valueForKey:@"urlToImage"];
        if ([_imageURLString isKindOfClass:[NSNull class]]) {
            _imageURLString = @"";
        }
        NSString *publishDateString = [dictionary valueForKey:@"publishedAt"];
        if ([publishDateString isKindOfClass:[NSNull class]]) {
            publishDateString = @"";
        }
        _publishDate = dateFromString(publishDateString);
        _content = [dictionary valueForKey:@"content"];
        if ([_content isKindOfClass:[NSNull class]]) {
            _content = @"";
        }
    }
    
    return self;
}

NSDate *dateFromString(NSString *dateString) {
    if (!dateString) {
        return nil;
    }
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    NSString *formattedDateString = [dateString stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    formattedDateString = [formattedDateString stringByReplacingOccurrencesOfString:@"Z" withString:@" "];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    return [dateFormatter dateFromString:formattedDateString];
}

@end
