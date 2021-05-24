//
//  NewsItem.h
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 21.05.2021.
//

#import <Foundation/Foundation.h>

@interface NewsItem : NSObject

@property (nonatomic, strong) NSString *sourceId;
@property (nonatomic, strong) NSString *sourceName;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *descriptionText;
@property (nonatomic, strong) NSString *newsURLString;
@property (nonatomic, strong) NSString *imageURLString;
@property (nonatomic, strong) NSDate *publishDate;
@property (nonatomic, strong) NSString *content;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
