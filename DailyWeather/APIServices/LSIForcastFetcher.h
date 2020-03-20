//
//  LSIForcastFetcher.h
//  DailyWeather
//
//  Created by Michael on 3/19/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "LSIWeatherForecast.h"
#import "LSICurrentForecast.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

typedef void (^LSIWeatherForcastCompletion)(LSIWeatherForecast * _Nullable forcast, NSError * _Nullable error);

@class LSIDailyForecast;
@class LSICurrentForecast;
@class LSIHourlyForecast;

NS_ASSUME_NONNULL_BEGIN

@interface LSIForcastFetcher : NSObject

@property LSIWeatherForecast *allForcast;

-(void)fetchforcastWithLatitude:(CLLocationDegrees)latitude
                      longitude:(CLLocationDegrees)longitude
                     completion:(void(^)(LSIWeatherForecast *))completion;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
