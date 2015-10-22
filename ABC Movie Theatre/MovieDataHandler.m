//
//  MovieDataHandler.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/20/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "MovieDataHandler.h"
#import "CoreDataConstants.h"
#import "Movie.h"

@implementation MovieDataHandler

@synthesize coreDataManager;

#pragma mark Initialization of MovieDataHandler.

- (instancetype)init {
    self = [super init];
    return self;
}

#pragma mark Public methods.

- (Movie *)retrieveMovie:(NSString *)movieName
  inManagedObjectContext:(NSManagedObjectContext *)managedObjectContext {
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:MOVIE_ENTITY];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K == [c] %@", NAME_ATTRIBUTE , movieName];
    [request setPredicate:predicate];
    
    return [super retrieveEntityWithRequest:request
                     inManagedObjectContext:managedObjectContext];
}

- (void)storeMovieInfo:(NSDictionary *)movieInfo {
    
    Movie *movie = [self retrieveMovie:movieInfo[NAME_ATTRIBUTE]
                inManagedObjectContext:self.coreDataManager.syncManagedObjectContext];
    
    if (!movie) {
        movie = [super getNewEntityByType:MOVIE_ENTITY];
        movie.name = movieInfo[NAME_ATTRIBUTE];
        movie.year = [NSNumber numberWithInt:[movieInfo[YEAR_ATTRIBUTE] intValue]];
        movie.genre = movieInfo[GENRE_ATTRIBUTE];
        movie.cast = [NSArray arrayWithArray:movieInfo[CAST_ATTRIBUTE]];
        movie.fiction = [NSNumber numberWithInt:[movieInfo[FICTION_ATTRIBUTE] intValue]];
        movie.score = [NSNumber numberWithFloat:[movieInfo[SCORE_ATTRIBUTE] floatValue]];
    }
}

@end
