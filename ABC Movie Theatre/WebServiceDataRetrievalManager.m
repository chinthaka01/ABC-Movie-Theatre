//
//  WebServiceDataRetrievalManager.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "WebServiceDataRetrievalManager.h"
#import "MovieRetrieval.h"
#import "GenreRetrieval.h"
#import "DataHandlerManager.h"
#import "CoreDataManager.h"

@interface WebServiceDataRetrievalManager ()

/**
 *  The MovieRetrieval class instance to use to access Movie data related web services.
 */
@property (nonatomic) MovieRetrieval *movieRetrieval;

/**
 *  The GenreRetrieval class instance to use to access Genre data related web services.
 */
@property (nonatomic) GenreRetrieval *genreRetrieval;

/**
 *  The DataHandlerManager instance to access Core Data entities.
 */
@property (nonatomic) DataHandlerManager *dataHandlerManager;

@end

@implementation WebServiceDataRetrievalManager

# pragma mark Singleton instantiation of WebServiceDataRetrievalManager.

+ (WebServiceDataRetrievalManager *)sharedInstance {
    static WebServiceDataRetrievalManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WebServiceDataRetrievalManager alloc] init];
    });
    
    return _sharedInstance;
}

# pragma mark Public methods.

- (void)retrieveMoviesWithCallBack:(void (^)(NSError *))handler {
    [self.movieRetrieval retrieveDataWithCallBack:^(NSArray *result, NSError *error) {
        
        if (result && result.count > 0 && !error) {
            
            [self.dataHandlerManager storeMoviesInfo:result];
            
            [[CoreDataManager sharedInstance] saveContext:^(BOOL success, NSError *error) {
                handler(nil);
            }];
        } else {
            handler(error);
        }
    }];
}

- (void)retrieveGenreWithCallBack:(void (^)(NSError *))handler {
    [self.genreRetrieval retrieveDataWithCallBack:^(NSArray *result, NSError *error) {
        
        if (result && result.count > 0 && !error) {
            
            [self.dataHandlerManager storeGenresInfo:result];
            
            [[CoreDataManager sharedInstance] saveContext:^(BOOL success, NSError *error) {
                handler(error);
            }];
        }
    }];
}

- (void)addMovie:(NSDictionary *)movieInfo callBack:(void (^)(NSError *))handler {
    
    [self.movieRetrieval sendData:movieInfo callBack:^(NSArray *response, NSError *error) {
        
        if (!error) {
            [self.dataHandlerManager storeAddedMovieInfo:movieInfo callBack:^{
                [[CoreDataManager sharedInstance] saveContext:^(BOOL success, NSError *error) {
                    handler(error);
                }];
            }];
        } else {
            handler(error);
        }
    }];
}

# pragma mark Accessor methods of the properties..

- (MovieRetrieval *)movieRetrieval {
    if (_movieRetrieval == nil) {
        _movieRetrieval = [[[MovieRetrieval class] alloc] init];
    }
    
    return _movieRetrieval;
}

- (GenreRetrieval *)genreRetrieval {
    if (_genreRetrieval == nil) {
        _genreRetrieval = [[[GenreRetrieval class] alloc] init];
    }
    
    return _genreRetrieval;
}

- (DataHandlerManager *)dataHandlerManager
{
    if (_dataHandlerManager == nil) {
        _dataHandlerManager = [DataHandlerManager sharedInstance];
    }
    
    return _dataHandlerManager;
}

@end
