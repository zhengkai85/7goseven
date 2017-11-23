//
//  LocationSerchShowViewController.h
//  TIMChat
//
//  Created by zhengkai on 16/12/27.
//  Copyright © 2016年 AlexiChen. All rights reserved.
//

#import "RootViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface LocationSerchShowViewController : RootViewController
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *resultsArray;
@property (nonatomic, strong) void (^sendLocation)(BMKPoiInfo *poiInfo);
@end

