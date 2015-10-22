//
//  MovieDataModel.m
//  ABC Movie Theatre
//
//  Created by Chinthaka Perera on 10/22/15.
//  Copyright (c) 2015 ABC. All rights reserved.
//

#import "MovieDataModel.h"
#import "DataHandlerManager.h"
#import "CoreDataManager.h"
#import "Movie.h"

@implementation MovieDataModel

# pragma mark Public methods.

- (BOOL)validateRequeiredDataExistence {
    
    BOOL existData = NO;
    
    if (self.movieName &&
        self.year &&
        self.genre &&
        self.fiction &&
        self.cast &&
        self.score) {
        
        existData = YES;
    }
    
    return existData;
}

- (BOOL)validateMovieName {
    
    BOOL validMovieName = NO;
    
    Movie *movie = [[DataHandlerManager sharedInstance] retrieveMovie:self.movieName inManagedObjectContext:[[CoreDataManager sharedInstance] syncManagedObjectContext]];
    
    if (!movie) {
        validMovieName = YES;
    }
    
    return validMovieName;
}

#pragma mark accessor methods of the properties.

- (void)setMovieName:(NSString *)movieName {
    _movieName = nil;
    
    if (movieName) {
        _movieName = movieName;
    }
}

- (void)setYear:(NSString *)year {
    _year = nil;
    
    if (year) {
        _year = year;
    }
}

- (void)setGenre:(Genre *)genre {
    _genre = nil;
    
    if (genre) {
        _genre = genre;
    }
}

- (void)setFiction:(NSNumber *)fiction {
    _fiction = nil;
    
    if (fiction) {
        _fiction = fiction;
    }
}

- (void)setCast:(NSArray *)cast {
    _cast = nil;
    
    if (cast && cast.count > 0) {
        _cast = [NSArray arrayWithArray:cast];
    }
}

- (void)setScore:(NSNumber *)score {
    _score = nil;
    
    if (score) {
        _score = score;
    }
}

@end
