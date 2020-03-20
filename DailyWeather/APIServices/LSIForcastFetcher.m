//
//  LSIForcastFetcher.m
//  DailyWeather
//
//  Created by Michael on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIForcastFetcher.h"
#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherForecast.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

static NSString *baseURLString = @"https://api.darksky.net/forecast/";

static NSString *apiKey = @"4c4947ca52f2fd6219f4ad83f35d9dd0";

@implementation LSIForcastFetcher

- (void)fetchforcastWithLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude completion:(void (^)(LSIWeatherForecast * _Nullable))completion {
    
    NSString *baseURLString = [NSString stringWithFormat:@"https://api.darksky.net/forecast/%@/%f,%f", apiKey, latitude, longitude];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:baseURLString];
    
    NSNumber *latNum = [[NSNumber alloc] initWithDouble:latitude];
    NSNumber *longNum = [[NSNumber alloc] initWithDouble:longitude];
    
    NSString *latString = [NSString stringWithFormat:@"%f", [latNum doubleValue]];
    NSString *longString = [NSString stringWithFormat:@"%f", [longNum doubleValue]];
    
    urlComponents.queryItems = @[
        [NSURLQueryItem queryItemWithName:apiKey value:nil],
        [NSURLQueryItem queryItemWithName:latString value:nil],
        [NSURLQueryItem queryItemWithName:longString value:nil]
    ];
    
    NSURL *url = urlComponents.URL;
    NSLog(@"url: %@", url);
    
    NSURLSessionDataTask *task = [NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            completion(nil);
            NSLog(@"Error fetching weather forecast from server: %@", error);
            return;
        }
        if (!data) {
            NSLog(@"No data returned from data task");
            completion(nil);
            return;
        }
        
        NSError *jsonError = nil;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (jsonError) {
            NSLog(@"Error parsing weather forcast json: %@", jsonError);
            completion(nil);
            return;
        }
        NSLog(@"Success!");
//        LSIWeatherForecast *allForcast = [[LSIWeatherForecast alloc] initWithDictionary:json];
//        self.allForcast = allForcast;
        self.allForcast = [[LSIWeatherForecast alloc] initWithDictionary:json];
        
        completion(self.allForcast);
        
    }];
    [task resume];
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    LSIWeatherForecast *allForecast = [[LSIWeatherForecast alloc] initWithDictionary: dictionary];
    self = [super init]; // Boiler plate code
    if (self) {
        _allForcast = allForecast; // set instance variable
    }
    return self;
}




@end
