//
//  LSIWeatherForecast.m
//  DailyWeather
//
//  Created by patelpra on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSIWeatherForecast.h"
#import "LSICurrentWeather.h"
#import "LSIDailyForecast.h"
#import "LSIHourlyForecast.h"

@implementation LSIWeatherForecast

- (instancetype)initWithLatitude:(double)latitude
                       longitude:(double)longitude
                        timezone:(NSString *)timezone
                  currentWeather:(LSICurrentWeather *)current
                   dailyForecast:(NSArray<LSIDailyForecast *> *)daily
                  hourlyForecast:(NSArray<LSIHourlyForecast *> *)hourly
{
    if (self = [super init]) {
        _latitude = latitude;
        _longitude = longitude;
        _timezone = timezone;
        _current = current;
        _daily = daily.copy;
        _hourly = hourly.copy;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSNumber *latitude = [dictionary objectForKey:@"latitude"];
    if (![latitude isKindOfClass:[NSNumber class]]) return nil;
    
    NSNumber *longitude = [dictionary objectForKey:@"longitude"];
    if (![longitude isKindOfClass:[NSNumber class]]) return nil;
    
    NSString *timezone = [dictionary objectForKey:@"timezone"];
    if ([timezone isKindOfClass:[NSNull class]]) {
        timezone = nil;
    } else if (![timezone isKindOfClass:[NSString class]]) return nil;
    
    
    NSDictionary *currentWeatherDictionary = [dictionary objectForKey:@"current"];
    if ([currentWeatherDictionary isKindOfClass:[NSNull class]]) {
        currentWeatherDictionary = nil;
    } else if (![currentWeatherDictionary isKindOfClass:[NSDictionary class]]) return nil;
    
    LSICurrentWeather *currentWeather = [[LSICurrentWeather alloc] initWithDictionary:currentWeatherDictionary];
    
    NSDictionary *dailyDictionary = [dictionary objectForKey:@"daily"];
    if (![dailyDictionary isKindOfClass:[NSDictionary class]]) return nil;
    
    NSArray *dailyDataDictionaries = [dailyDictionary objectForKey:@"data"];
    if (![dailyDataDictionaries isKindOfClass:[NSArray class]]) return nil;
    
    NSMutableArray *dailyForecasts = [[NSMutableArray alloc] initWithCapacity:dailyDataDictionaries.count];
    
    for (NSDictionary *dailyDataDictionary in dailyDataDictionaries) {
        if (![dailyDataDictionary isKindOfClass:[NSDictionary class]]) continue;
        
        LSIDailyForecast *dailyForecast = [[LSIDailyForecast alloc] initWithDictionary:dailyDataDictionary];
        
        if (dailyForecast) {
            [dailyForecasts addObject:dailyForecast];
        } else {
            
            NSLog(@"Unable to parse daily data dictionary: %@", dailyDataDictionary);
        }
    }
    
    NSDictionary *hourlyDictionary = [dictionary objectForKey:@"hourly"];
    if (![hourlyDictionary isKindOfClass:[NSDictionary class]]) return nil;
    
    NSArray *hourlyDataDictionaries = [hourlyDictionary objectForKey:@"data"];
    if (![hourlyDataDictionaries isKindOfClass:[NSArray class]]) return nil;
    
    NSMutableArray *hourlyForecasts = [[NSMutableArray alloc] initWithCapacity:hourlyDataDictionaries.count];
    
    for (NSDictionary *hourlyDataDictionary in hourlyDataDictionaries) {
        if (![hourlyDataDictionary isKindOfClass:[NSDictionary class]]) continue;
        
        LSIHourlyForecast *hourlyForecast = [[LSIHourlyForecast alloc] initWithDictionary:hourlyDataDictionary];
        
        if (hourlyForecast) {
            [hourlyForecasts addObject:hourlyForecast];
        } else {
            
            NSLog(@"Unable to parse hourly data dictionary: %@", hourlyDataDictionary);
        }
    }
    
    return [self initWithLatitude:latitude.doubleValue
                        longitude:longitude.doubleValue
                         timezone:timezone currentWeather:currentWeather
                    dailyForecast:dailyForecasts
                   hourlyForecast:hourlyForecasts];
}

@end
