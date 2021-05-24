//
//  APIManager.h
//  HereIsTheNews
//
//  Created by Grigory Stolyarov on 21.05.2021.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject

+ (instancetype)sharedInstance;
- (void)newsForCountry:(NSString *)countryCode withCompletion:(void (^)(NSArray *news))completion;

@end
