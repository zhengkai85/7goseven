//
//  LocationDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-4-15.
//  Copyright (c) 2013年 baidu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import "RootViewController.h"

@interface LocationDemoViewController :  RootViewController <BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate>{
    BMKLocationService* _locService;
    BMKGeoCodeSearch* _geocodesearch;
    BMKPoiSearch* _poisearch;
}

- (void)addPointAnnotation:(CLLocationCoordinate2D)pt;

@property (nonatomic, strong) void (^sendLocation)(NSDictionary *msg);

@end

