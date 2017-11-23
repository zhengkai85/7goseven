//
//  LocationDemoViewController.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-4-15.
//  Copyright (c) 2013年 baidu. All rights reserved.
//
#import "LocationDemoViewController.h"
#import "LocationSerchShowViewController.h"

@interface LocationDemoViewController () <UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrDataSoruce;
@property (nonatomic, assign) NSInteger sel;
@property (nonatomic, strong) BMKPointAnnotation* pointAnnotation;

@property (nonatomic, strong) UISearchController *searchController;
@property (nonatomic, strong) LocationSerchShowViewController *searchResultVc;
@property (nonatomic, strong) UIView *viewStatusBar;
@property (nonatomic, strong) BMKMapView *mapView;
@property (nonatomic, assign) BOOL bLock;
@property (nonatomic, strong) BMKPoiInfo *info;
@end

@implementation LocationDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"位置信息";
    
    [self initSearchController];
    BMKMapManager *mapManager = [[BMKMapManager alloc]init];
     [mapManager start:BAIDUKEY generalDelegate:nil];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, self.searchController.searchBar.bottom,SCREEN_WIDTH, 240)];
    [self.view addSubview:_mapView];
    
    self.arrDataSoruce = [[NSMutableArray alloc] init];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _mapView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT-TAB_BAR_HEIGHT-_mapView.bottom) style:UITableViewStyleGrouped];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 40;

    self.bLock = NO;

    self.sel = 0;
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){
        self.navigationController.navigationBar.translucent = NO;
    }
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _locService = [[BMKLocationService alloc]init];
    _poisearch = [[BMKPoiSearch alloc]init];

    _mapView.zoomLevel = 15;

    [self startLocation:nil];

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"确定"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(doSubmit)];
}




- (void)doSubmit {
    if(self.sendLocation) {
//        ;
//        NSString *city = @"";
//        NSString *province = @"";
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"citys" ofType:@"plist"];
//        if (path) {
//            NSData *data = [NSData dataWithContentsOfFile:path];
//            NSDictionary *dicCity = [NSDictionary dictionaryWithPlistData:data];
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@",self.info.city];
//            NSArray *temp = [dicCity.allKeys filteredArrayUsingPredicate:predicate];
//            if(temp.count > 0) {
//                city = dicCity[temp[0]];
//            }
//            PPLog(@"%@",city);
//
//        }
        NSDictionary *dic = @{@"name": self.info.name,
                              @"address": self.info.address,
                              @"latitude" : [NSNumber numberWithDouble:self.info.pt.latitude],
                              @"longitude" : [NSNumber numberWithDouble:self.info.pt.longitude]};
        self.sendLocation(dic);
        [[GotoAppdelegate sharedAppDelegate] popViewController];
    }
    
}

#pragma mark - search
- (void)initSearchController {
    
    __weak LocationDemoViewController *wSelf = self;
    self.searchResultVc = [[LocationSerchShowViewController alloc] init];
    self.searchResultVc.sendLocation = ^(BMKPoiInfo *poiInfo) {
        wSelf.bLock = YES;
        wSelf.sel = 0;
        wSelf.coordinate = poiInfo.pt;
        wSelf.info = poiInfo;
        [[wSelf mapView] setCenterCoordinate:poiInfo.pt];
        [wSelf getNewAddress];        
        [wSelf addPointAnnotation];
    };
        
    UINavigationController *resultVC = [[UINavigationController alloc] initWithRootViewController:self.searchResultVc];
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:resultVC];
    self.searchController.searchResultsUpdater = self;
    self.searchController.definesPresentationContext = YES;
    self.searchController.searchBar.frame = CGRectMake(0,
                                                       0,
                                                       self.searchController.searchBar.frame.size.width,
                                                       44);
    [self.view addSubview:self.searchController.searchBar];
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.barTintColor = COLOR_TABARVIEWGRAY;
    self.searchController.searchResultsUpdater = self;
    UIImageView *barImageView = [[[self.searchController.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = self.searchController.searchBar.barTintColor.CGColor;
    barImageView.layer.borderWidth = 1;
    
    self.searchResultVc.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 1)];
    self.definesPresentationContext = YES;
}


-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
//    self.searchController.searchBar.barTintColor = COLOR_PURPLE;
    UIImageView *barImageView = [[[self.searchController.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = self.searchController.searchBar.barTintColor.CGColor;
    barImageView.layer.borderWidth = 1;
    
    searchBar.showsCancelButton = YES;
    UIButton *canceLBtn = [searchBar valueForKey:@"cancelButton"];
    [canceLBtn setTitle:@"取消" forState:UIControlStateNormal];
    [canceLBtn setTitleColor:COLOR_TEXT forState:UIControlStateNormal];
    
    if(!_viewStatusBar) {
        _viewStatusBar = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
        _viewStatusBar.backgroundColor = self.searchController.searchBar.barTintColor;
        [[[UIApplication sharedApplication] keyWindow] addSubview:_viewStatusBar];
    }
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    self.searchController.searchBar.barTintColor = COLOR_TABBG;
    UIImageView *barImageView = [[[self.searchController.searchBar.subviews firstObject] subviews] firstObject];
    barImageView.layer.borderColor = self.searchController.searchBar.barTintColor.CGColor;
    barImageView.layer.borderWidth = 1;
    
    [_viewStatusBar removeFromSuperview];
    _viewStatusBar = nil;
}

#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{

    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 20;
    citySearchOption.city= @"福州";
    citySearchOption.keyword = searchController.searchBar.text;
    [_poisearch poiSearchInCity:citySearchOption];
}


#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    if (error == BMK_SEARCH_NO_ERROR) {
        UINavigationController *navController = (UINavigationController *)self.searchController.searchResultsController;
        LocationSerchShowViewController *resultVC = (LocationSerchShowViewController *)navController.topViewController;
        resultVC.resultsArray = [[NSArray alloc] initWithArray:result.poiInfoList];
        [resultVC.tableView reloadData];


    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}

#pragma mark - map
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    if(self.bLock) {
        return;
    }
    
    self.coordinate = _mapView.centerCoordinate;
    _sel = 0;
    [self addPointAnnotation];
    [self getNewAddress];
}


- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    NSString *AnnotationViewID = @"renameMark";
    BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        // 设置颜色
        annotationView.pinColor = BMKPinAnnotationColorPurple;
        // 从天上掉下效果
        annotationView.animatesDrop = YES;
        // 设置可拖拽
        annotationView.draggable = YES;
    }
    return annotationView;

}

- (void)addPointAnnotation
{
    if (_pointAnnotation == nil) {
        _pointAnnotation = [[BMKPointAnnotation alloc]init];
    }
    
    _pointAnnotation.coordinate = _coordinate;
    [_mapView addAnnotation:_pointAnnotation];
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.searchController.searchBar.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    self.tableView.delegate = nil;
    self.tableView.dataSource = nil;
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil;
    _poisearch.delegate = nil; // 不用时，置nil
    _searchController.delegate = nil;
    self.searchController.searchBar.delegate = nil;
    _searchController.searchResultsUpdater = nil;
}


//普通态
-(IBAction)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
}

//停止定位

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
	NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
//- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
//{
//    [_mapView updateLocationData:userLocation];
//    NSLog(@"heading is %@",userLocation.heading);
//
//}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude)];
    self.coordinate = userLocation.location.coordinate;
    [_locService stopUserLocationService];
    
    [self addPointAnnotation];

}

- (void)getNewAddress {
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = self.coordinate;
    [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    array = [NSArray arrayWithArray:_mapView.overlays];
    if (error == 0) {
        [self.arrDataSoruce removeAllObjects];
        [self.arrDataSoruce addObjectsFromArray:result.poiList];
        [self.tableView reloadData];
        self.bLock = NO;
    }
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSoruce.count;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellWithIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellWithIdentifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = COLOR_TEXT;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
        cell.detailTextLabel.textColor = COLOR_DETAIL;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    BMKPoiInfo *poiInfo = self.arrDataSoruce[indexPath.row];
    cell.textLabel.text = poiInfo.name;
    cell.detailTextLabel.text = poiInfo.address;

    
    if(self.sel == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.info = poiInfo;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.sel = indexPath.row;
    [self.tableView reloadData];
    BMKPoiInfo *poiInfo = self.arrDataSoruce[indexPath.row];
    self.coordinate = poiInfo.pt;
    [self addPointAnnotation];
    self.info = poiInfo;
}
@end
