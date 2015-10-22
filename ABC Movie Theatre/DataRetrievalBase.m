//
//  DataRetrievalBase.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "DataRetrievalBase.h"
#import "AFNetworking.h"

@implementation DataRetrievalBase
{
    /**
     *  The URL of the web services without the specific methods.
     */
    NSString *_baseUrl;
}

# pragma mark Initialization of DataRetrievalBase.

- (instancetype)init {
    self = [super init];
    
    if (self) {
        _baseUrl = @"http://mobiletest.mazarin.lk/movieservice/rest";
    }
    
    return self;
}

#pragma mark Public methods.

- (void)retrieveDataWithCallBack:(void (^)(NSArray *, NSError *))handler {
    
    NSURL *baseURL = [NSURL URLWithString:_baseUrl];
    NSString *path = self.requestPath;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:path parameters:nil success:^(NSURLSessionDataTask *task, id responseObject)
     {
         handler(responseObject, nil);
     }failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         handler(nil, error);
     }];
}

- (void)sendData:(NSDictionary *)data callBack:(void (^)(NSArray *, NSError *))handler {
    
    NSURL *baseURL = [NSURL URLWithString:_baseUrl];
    NSString *path = self.requestPath;
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    [manager POST:path parameters:data success:^(NSURLSessionDataTask *task, id responseObject)
     {
         handler(responseObject, nil);
     }failure:^(NSURLSessionDataTask *task, NSError *error)
     {
         handler(nil, error);
     }];
}

@end
