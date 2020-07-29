//
//  LSICurrentWeather.m
//  DailyWeather
//
//  Created by patelpra on 7/28/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "LSICurrentWeather.h"

@implementation LSICurrentWeather

- (instancetype)initWithTime:(NSDate *)time
            summary:(NSString *)summary
               icon:(NSString *)icon
  precipProbability:(double)precipProbability
    precipIntensity:(double)precipIntensity
        temperature:(double)temperature
apparentTemperature:(double)apparentTemperature
           humidity:(double)humidity
           pressure:(double)pressure
          windSpeed:(double)windSpeed
        windBearing:(double)windBearing
            uvIndex:(double)uvIndex
{
    if (self = [super init]) {
        _time = time;
        _summary = summary;
        _icon = icon;
        _precipProbability = precipProbability;
        _precipIntensity = precipIntensity;
        _temperature = temperature;
        _apparentTemperature = apparentTemperature;
        _humidity = humidity;
        _pressure = pressure;
        _windSpeed = windSpeed;
        _windBearing = windBearing;
        _uvIndex = uvIndex;
    }
    return self;
}



@end
