//
//  MovieRetrieval.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "MovieRetrieval.h"

@implementation MovieRetrieval

# pragma mark Initialization of MovieRetrieval.

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.requestPath = @"movies";
    }
    
    return self;
}

# pragma mark Public methods.

- (void)retrieveDataWithCallBack:(void (^)(NSArray *, NSError *))handler {
    [super retrieveDataWithCallBack:handler];
}

- (void)sendData:(NSDictionary *)data callBack:(void (^)(NSArray *, NSError *))handler {
    [super sendData:data callBack:handler];
}

@end
