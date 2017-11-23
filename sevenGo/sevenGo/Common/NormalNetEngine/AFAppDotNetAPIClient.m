// AFAppDotNetAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AFAppDotNetAPIClient.h"
#import "LCProgressHUD.h"
#import "PPNetworkCache.h"
#import "AppCacheData.h"

static NSString *token = @"da5f5d9b774c74d3faa6915217fc70fb";
static NSString *isOpenLog = @"0";



#define NSStringFormat(format,...) [NSString stringWithFormat:format,##__VA_ARGS__]


@implementation AFAppDotNetAPIClient

+ (instancetype)sharedClient {
    static AFAppDotNetAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *str = NetAPI;
        _sharedClient = [[AFAppDotNetAPIClient alloc] initWithBaseURL:[NSURL URLWithString:str]];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        _sharedClient.requestSerializer.timeoutInterval = 60;
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];    
    });
    
    return _sharedClient;
}

+ (NSURLSessionDataTask *)dealWithNet:(NSString*)interface
              param:(NSDictionary*)param
              block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    return [self dealWithNet:interface param:param isShowLoad:YES block:block];
    
}

+ (NSURLSessionDataTask *)dealWithNet:(NSString*)interface
              param:(NSDictionary*)param
         isShowLoad:(BOOL)isLoad
              block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block{
    return [self dealWithNet:interface param:param isShowLoad:isLoad cacheBlock:nil block:block];
}

+ (NSURLSessionDataTask *)dealWithNet:(NSString*)interface
              param:(NSDictionary*)param
         isShowLoad:(BOOL)isLoad
         cacheBlock:(void (^)(id cache))cacheBLock
              block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    if(isLoad) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
    }
    
    NSMutableDictionary *newDic = [[NSMutableDictionary alloc] initWithDictionary:param];
    [newDic setObject:token forKey:@"access_token"];
    [newDic setObject:APPVERSION forKey:@"version"];

    if(cacheBLock) {
        id cacheObj = [PPNetworkCache httpCacheForURL:interface parameters:param];
            cacheBLock(cacheObj);
    }
    
    __block NSURLSessionDataTask *task =
    [[AFAppDotNetAPIClient sharedClient] POST:interface
                                   parameters:newDic
                    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    } progress:^(NSProgress * _Nonnull uploadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if(isLoad) {
                            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
                        }
                        NSDictionary *dicJSON = (NSDictionary*)responseObject;
                        if ([isOpenLog boolValue]){
                            PPLog(@"responseObject = %@",responseObject);
                        }
                        
                        if(cacheBLock) {
                            [PPNetworkCache setHttpCache:responseObject URL:interface parameters:param];
                        }
                        NSInteger code = [dicJSON[@"code"] integerValue];
                        NSString *meg = dicJSON[@"info"];
                        if(code == 401) {
                            [[AppCacheData shareCachData] clearData];
                            [[AppDelegate sharedAppDelegate] enterLoginUI];
                            [LCProgressHUD showMessage:@"请重新登录"];
                            return ;
                        }
                        if(code != 200 && meg && [meg isNoEmpty]) {
                            block(dicJSON,code,meg);
                        } else {
                            block(dicJSON,code,@"");
                        }
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        if ([isOpenLog boolValue]) {PPLog(@"error = %@",error);}
                        if(isLoad) {
                            [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:NO];
                        }
                        //                        [HUDHelper alert:error.localizedDescription];
                        //[LCProgressHUD showFailure:error.localizedDescription];
                        block(nil,error.code,error.localizedDescription);
                    }];
    return task;
}


+ (void)upLoadFileNet:(NSString*)interface
                param:(NSDictionary*)param
                 name:(NSString*)name
                 data:(NSData*)fileData
           isShowLoad:(BOOL)showLoad
                block:(void (^)(id posts,NSInteger code,NSString *errorMsg))block {
    
    if(showLoad) {
        [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:NO];
    }
    
    [[AFAppDotNetAPIClient sharedClient] POST:interface
                                   parameters:param
                    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                        [formData appendPartWithFileData:fileData name:@"key1" fileName:[NSString stringWithFormat:@"%@.jpg",name] mimeType:@"image/jpeg"];
                    } progress:^(NSProgress * _Nonnull uploadProgress) {
                    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        if(showLoad) {
                            [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
                        }
                        block([responseObject valueForKeyPath:@"fileUrlInfos"], 1,[responseObject valueForKey:@"message"]);
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        if(showLoad) {
                            [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:NO];
                        }
                        if (block) {
                            block(@"", 0,@"文件上传失败");
                            
                            NSLog(@"************%@ net error %@",interface,error.localizedDescription);
                            if(error.code == -1009) {
                            }
                        }
                    }];
}

+ (NSString*)getOpenId {
    NSString *open_id = [[AppCacheData shareCachData] getOpen_id];
    
    if(!open_id) {
        [LCProgressHUD showFailure:@"未登录"];
        return @"";
    }
    
    if(open_id && [open_id isEmpty]) {
        [LCProgressHUD showFailure:@"未登录"];
        return @"";
    }
    
    return open_id;
    
}

@end

#pragma mark - NSDictionary,NSArray的分类
/*
 ************************************************************************************
 *新建NSDictionary与NSArray的分类, 控制台打印json数据中的中文
 ************************************************************************************
 */

#ifdef DEBUG
@implementation NSArray (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    [strM appendString:@")"];
    
    return strM;
}

@end

@implementation NSDictionary (PP)

- (NSString *)descriptionWithLocale:(id)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}
@end
#endif
