//
//  DataHandlerManager.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "DataHandlerManager.h"
#import "MovieDataHandler.h"
#import "GenreDataHandler.h"

@interface DataHandlerManager ()

/**
 *  The MovieDataHandler class instance to use to access Movie Core Data entities.
 */
@property (nonatomic) MovieDataHandler *movieDataHandler;

/**
 *  The GenreDataHandler class instance to use to access Genre Core Data entities.
 */
@property (nonatomic) GenreDataHandler *genreDataHandler;

@end

@implementation DataHandlerManager

# pragma mark Singleton instantiation of DataHandlerManager.

+ (DataHandlerManager *)sharedInstance {
    static DataHandlerManager *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[DataHandlerManager alloc] init];
    });
    
    return _sharedInstance;
}

# pragma mark Public methods.

- (void)storeMoviesInfo:(NSArray *)moviesInfo {
    for (NSDictionary *movieInfo in moviesInfo) {
        [self.movieDataHandler storeMovieInfo:movieInfo];
    }
}

- (void)storeAddedMovieInfo:(NSDictionary *)movieInfo callBack:(void (^)())handler {
    [self.movieDataHandler storeMovieInfo:movieInfo];
    handler();
}

- (void)storeGenresInfo:(NSArray *)genresInfo {
    for (NSString *genre in genresInfo) {
        [self.genreDataHandler storeGenre:genre];
    }
}

- (Movie *)retrieveMovie:(NSString *)movieName
  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    return [self.movieDataHandler retrieveMovie:movieName inManagedObjectContext:managedObjectContext];
}

- (Genre *)retrieveGenre:(NSString *)genre
  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
  
    return [self.genreDataHandler retrieveGenre:genre inManagedObjectContext:managedObjectContext];
}

#pragma mark Accessor methods of the properties.

- (MovieDataHandler *)movieDataHandler {
    if (_movieDataHandler == nil) {
        _movieDataHandler = [[MovieDataHandler alloc] init];
    }
    
    return _movieDataHandler;
}

- (GenreDataHandler *)genreDataHandler {
    if (_genreDataHandler == nil) {
        _genreDataHandler = [[GenreDataHandler alloc] init];
    }
    
    return _genreDataHandler;
}

@end
