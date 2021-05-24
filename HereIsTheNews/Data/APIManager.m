//
//  APIManager.m
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 21.05.2021.
//

#import "APIManager.h"
#import "NewsItem.h"

#define API_TOKEN @"41e98a78ef4d494e96ba2e7b19248120"
#define API_URL @"https://newsapi.org/v2/"
#define API_ENDPOINT_TOP @"top-headlines"

@implementation APIManager

+ (instancetype)sharedInstance {
    static APIManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[APIManager alloc] init];
    });
    return instance;
}

- (void)load:(NSString *)urlString withCompletion:(void (^)(id _Nullable result))completion {
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:urlString]
                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion([NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil]);
    }] resume] ;
}

- (void)newsForCountry:(NSString *)countryCode withCompletion:(void (^)(NSArray *news))completion {
    NSString *urlString = [NSString stringWithFormat:@"%@%@?apiKey=%@&pageSize=100&country=%@", API_URL, API_ENDPOINT_TOP, API_TOKEN, countryCode];
    [self load:urlString withCompletion:^(id _Nullable result) {
        NSDictionary *response = result;
        if (response) {
            NSDictionary *json = [response valueForKey:@"articles"];
            NSMutableArray *array = [NSMutableArray new];
            for (NSDictionary *jsonObject in json) {
                NewsItem *newsItem = [[NewsItem alloc] initWithDictionary:jsonObject];
                [array addObject:newsItem];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(array);
            });
        }
    }];
}

- (NSArray *)arrayFromFileName:(NSString *)fileName ofType:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

@end
