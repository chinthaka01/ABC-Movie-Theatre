//
//  GenreRetrieval.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "GenreRetrieval.h"

@implementation GenreRetrieval

# pragma mark Initialization of GenreRetrieval.

- (instancetype)init {
    self = [super init];
    
    if (self) {
        self.requestPath = @"movies/genres";
    }
    
    return self;
}

# pragma mark Public methods.

- (void)retrieveDataWithCallBack:(void (^)(NSArray *, NSError *))handler {
    
    [super retrieveDataWithCallBack:handler];
}

@end
